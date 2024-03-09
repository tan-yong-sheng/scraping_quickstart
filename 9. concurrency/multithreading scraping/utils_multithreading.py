# Credit: https://github.com/michaelharms/comcrawl/blob/a89236080c5e7f4ce6a2e0d39c5f59671f22181e/comcrawl/utils/multithreading.py#L12

# note: this script is very useful way to make the requests session to be multithreading 
# and easily called simply by scraper_func(session, url, params, headers, threads=4)

# needs more work to investigate it

"""Multithreading Helpers.

This module contains utility functions
to manage multi-threading.

"""

from typing import Callable, List
from concurrent import futures
import json
import requests




def search_multiple_indexes(url: str,
                            indexes: list[str],
                            threads: int = None) -> list[dict]:
    """Searches multiple Common Crawl Indexes for URL pattern.

    Args:
        url: The URL pattern to search for.
        indexes: List of Common Crawl Indexes to search through.
        threads: Number of threads to use for faster parallel search on
            multiple threads.

    Returns:
        List of all results found throughout the specified
        Common Crawl indexes.

    """
    results = []

    # multi-threaded search
    if threads:
        mulithreaded_search = make_multithreaded(search_single_index,
                                                 threads)
        results = mulithreaded_search(indexes, url)

    # single-threaded search
    else:
        for index in indexes:
            index_results = search_single_index(index, url)
            results.extend(index_results)

    return results


def make_multithreaded(func: Callable,
                       threads: int) -> Callable:
    """Creates a multithreaded version of a function.

    Args:
        func: Function that is meant to be executed on
            a list of input objects.
        threads: The number of threads the multithreaded
            version of the function should use.

    Returns:
        A multithreaded version of the `func` input function.

    """

    def multithreaded_function(input_list: List, *args) -> List:
        """Executes function on input list using multiple threads.

        Args:
            input_list: The list of objects a function should be
                executed on.
            *args: Variable length argument list of additional
                parameters needed for the function to be executed.

        Returns:
            List of results after all input list elements were
            processed. Input order might not be preserved in
            output list.

        """
        results = []

        with futures.ThreadPoolExecutor(max_workers=threads) as executor:
            future_to_input_item = {
                executor.submit(
                    func,
                    input_item,
                    *args
                ): input_item for input_item in input_list
            }

            for future in futures.as_completed(future_to_input_item):
                result = future.result()

                if isinstance(result, List):
                    results.extend(result)
                else:
                    results.append(result)

        return results

    return multithreaded_function