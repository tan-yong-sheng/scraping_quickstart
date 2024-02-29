# Credit: this is the code from 2captcha support team
# My personal Reference: https://2captcha.com/support/tickets/310146

import re
import time
import requests
from seleniumbase import Driver
from selenium.webdriver.common.by import By
from dotenv import load_dotenv
import os

_ = load_dotenv()

my_key  = os.environ["2CAPTCHA_API_KEY"]
INVESTINGNOTE_USERNAME = os.environ["INVESTINGNOTE_USERNAME"]
INVESTINGNOTE_PASSWORD = os.environ["INVESTINGNOTE_PASSWORD"]

# proxy1 = "xxxx:xxxx@xx.xxx.xx.xxx:xxxx"# YOUR PROXY
driver = Driver(uc=True, headless=False) #, proxy=proxy1)

url = 'https://www.investingnote.com/users/sign_in'
driver.get(url)
time.sleep(5)

src = driver.find_element(By.TAG_NAME, "iframe").get_attribute("src")
pattern = r'k=([^&]+)'
result = re.search(pattern, src)
sitekey = result.group(1)
print("sitekey: ", sitekey)
driver.find_element(By.ID, "user_login").send_keys(INVESTINGNOTE_USERNAME)
time.sleep(1)
driver.find_element(By.ID, "user_password").send_keys(INVESTINGNOTE_PASSWORD)

try:
    data = {"key": my_key,
            "method": "userrecaptcha ",
            "googlekey": sitekey,
            "json": 1,
            "pageurl": url,
            # "proxy": proxy1,
            "proxytype": "HTTP",
            }
    response = requests.post(f"https://2captcha.com/in.php?", data=data)
    print("Request has been sent: ", response.text)
    s = response.json()["request"]
    time.sleep(20)
    while True:
        solu = requests.get(f"https://2captcha.com/res.php?key={my_key}&action=get&json=1&id={s}").json()
        if solu["request"] == "CAPCHA_NOT_READY":
            print(solu["request"])
            time.sleep(10)
        elif "ERROR" in solu["request"]:
            print(solu["request"])
            driver.close()
            driver.quit()
            exit(0)
        else:
            break
    for key, value in solu.items():
        print(key, ": ", value)

    solu = solu["request"]
    time.sleep(2)

    driver.execute_script("document.getElementsByName('g-recaptcha-response')[0].value = arguments[0];", solu)
    iframe = driver.find_element(By.XPATH,
                                 "/html/body/div[1]/div[1]/div[2]/div/div/div/form/fieldset/section[3]/div/div/div/iframe")
    # This method is used to identify a frame with the help of frame id and then switch the focus to that particular frame.
    driver.switch_to_frame(iframe)
    el = driver.find_element(By.ID, "recaptcha-token")
    driver.execute_script(f"arguments[0].setAttribute('value', '{solu}');", el)
    time.sleep(1)
    # to move out the current frame to the page level
    driver.switch_to.default_content()

    script = """document.getElementById('sign-in-btn').removeAttribute('disabled');"""#Making the button visible
    driver.execute_script(script)

    time.sleep(2)
    print("Answer inserted")
    time.sleep(2)
    driver.find_element(By.ID, "sign-in-btn").click()#Click on the authorization button
    #your code
    time.sleep(50)

except Exception as ex:
    print(ex)
finally:
    time.sleep(1)
    driver.close()
    driver.quit()
