# Scraping Quickstart

This repository serves as a comprehensive introduction to web scraping techniques, suitable for beginners and intermediate Python users. It provides a hands-on learning experience through a series of Jupyter Notebooks, guiding you through various scraping methods.

## Getting Started

1. Clone the repository to your local machine by running this script on your terminal:
  ```bash
  git clone https://github.com/tan-yong-sheng/scraping-quickstart
  ```

2. Run `cd scraping-quickstart` on your terminal

2. Rename the `.env.sample` file to `.env`.

3. In the `.env` file, add the required credentials for the following services:

    - 2Captcha API key: Obtain your 2Captcha API key from https://2captcha.com/2captcha-api. This paid service helps you to bypass recaptcha.
    - Brightdata's proxy username, password, and hostname: Obtain your proxy at https://brightdata.com/ to rotate your IP address and reduce the possibility that you're detected as a scraping bot.


## Table of Contents

This repository covers a wide range of topics, including:

1. Scraping with APIs
2. Scraping static website
3. Handling JavaScript-rendered websites with headless browser
4. Bypassing anti-scraping measures with 2Captcha service
5. Use Brightdata Proxies to rotate IP addresses to prevent hitting rate limit

And much more

## Learning Resources
For a more in-depth understanding of web scraping techniques, refer to the accompanying blog: [https://tanyongsheng.com/blog/web-scraping-tutorial-with-python-2024-using-python-requests-beautifulsoup-selenium-anti-captcha-and-proxy/](https://tanyongsheng.com/blog/web-scraping-tutorial-with-python-2024-using-python-requests-beautifulsoup-selenium-anti-captcha-and-proxy/). This blog provides detailed explanations, code samples, and additional resources to complement the Jupyter Notebooks.

## Contributing
Contributions to this repository are welcome! If you have any suggestions, improvements, or additional examples, please feel free to open a pull request or submit an issue.

Happy scraping!
