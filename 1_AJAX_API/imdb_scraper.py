# -------------------------------------
# UPDATED: 1 July 2025

# This script, imdb_scraper.py, scrapes IMDb data.
# It utilizes IMDb's GraphQL API.
# You provide a movie ID as an argument, found in IMDb review URLs.
# For example, run it as: python imdb_scraper.py tt34956443.

# just an add-on to this series, please feel free to skip this if it's hard to you... 
# -------------------------------------

import requests
import json
import urllib.parse
import csv

def scrape_imdb_reviews(movie_id):
    base_url = "https://caching.graphql.imdb.com/"
    headers = {
        'accept': 'application/graphql+json, application/json',
        'accept-language': 'en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7',
        'content-type': 'application/json',
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'
    }

    all_reviews = []
    after_cursor = None # Initial cursor for pagination

    while True:
        variables = {
            "after": after_cursor,
            "const": movie_id,
            "filter": {},
            "first": 25,
            "locale": "en-US",
            "sort": {
                "by": "HELPFULNESS_SCORE",
                "order": "DESC"
            }
        }

        extensions = {
            "persistedQuery": {
                "sha256Hash": "8e851a269025170d18a33b296a5ced533529abb4e7bc3d6b96d1f36636e7f685",
                "version": 1
            }
        }

        params = {
            "operationName": "TitleReviewsRefine",
            "variables": urllib.parse.quote(json.dumps(variables, separators=(',', ':'))),
            "extensions": urllib.parse.quote(json.dumps(extensions, separators=(',', ':')))
        }
        
        # Manually construct the URL to avoid incorrect encoding of the JSON string by urlencode
        full_url = f"{base_url}?operationName={params['operationName']}&variables={params['variables']}&extensions={params['extensions']}"

        print(f"Fetching URL: {full_url}")

        try:
            response = requests.get(full_url, headers=headers)
            response.raise_for_status() # Raise an exception for HTTP errors
            data = response.json()

            # Process reviews
            reviews_data = data.get('data', {}).get('title', {}).get('reviews', {})
            for review_edge in reviews_data.get('edges', []):
                review_node = review_edge.get('node', {})
                extracted_review = {
                    'id': review_node.get('id'),
                    'user_id': review_node.get('author', {}).get('userId', {}),
                    'nickname': review_node.get('author', {}).get('nickName', {}),
                    'author_rating': review_node.get('authorRating'),
                    'summary_originalText': review_node.get('summary', {}).get('originalText'),
                    'text_originalText_plaidHtml': review_node.get('text', {}).get('originalText', {}).get('plaidHtml'),
                    'helpfulness_upvotes': review_node.get('helpfulness', {}).get('upVotes'),
                    'helpfulness_downvotes': review_node.get('helpfulness', {}).get('downVotes')
                }
                all_reviews.append(extracted_review)

            # Check for next page
            page_info = reviews_data.get('pageInfo', {})
            if page_info.get('hasNextPage'):
                after_cursor = page_info.get('endCursor')
            else:
                break # No more pages

        except requests.exceptions.RequestException as e:
            print(f"Request failed: {e}")
            break
        except json.JSONDecodeError as e:
            print(f"Failed to decode JSON: {e}")
            break
        except Exception as e:
            print(f"An unexpected error occurred: {e}")
            break
    
    return all_reviews

if __name__ == "__main__":
    import sys
    
    # Check if a movie ID is provided as a command-line argument
    if len(sys.argv) > 1:
        movie_id_to_scrape = sys.argv[1]
        
    else:
        print("Error: Please provide an IMDb movie ID as a command-line argument.")
        print("Example: python imdb_scraper.py tt34956443")
        print("You can find the movie ID from the IMDb reviews URL, e.g., for 'https://www.imdb.com/title/tt34956443/reviews/', the ID is 'tt34956443'.")
        sys.exit(1) # Exit the script with an error code

    print(f"Starting scraping for movie ID: {movie_id_to_scrape}")
    reviews = scrape_imdb_reviews(movie_id_to_scrape)
    print(reviews)
    print(f"Scraped {len(reviews)} reviews.")

    # You can now save or process the reviews as needed
    if reviews:
        csv_file = f'{movie_id_to_scrape}_imdb_reviews.csv'
        # Get all possible keys from all reviews to use as CSV headers
        all_keys = set()
        for review in reviews:
            all_keys.update(review.keys())
        
        # Sort keys to maintain consistent column order
        fieldnames = sorted(list(all_keys))

        with open(csv_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(reviews)
        print(f"Reviews saved to {csv_file}")
    else:
        print("No reviews to save.")
