from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import time
import random
import json

print("Обходим защиту QRATOR, интегрируем куки и юзер-агенты...")

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0"
]

with open('cookies.json') as f:
    COOKIES = json.load(f)

def get_gpu_data():
    base_url = "https://www.dns-shop.ru/catalog/17a89aab16404e77/videokarty/?p="
    options = Options()
    options.add_argument('--headless')
    gpu_data = []

    for i in range(1, 15):
        print(f"Парсим страницу {i}...")
        user_agent = random.choice(USER_AGENTS)
        options.add_argument(f'user-agent={user_agent}')
        driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
        wait = WebDriverWait(driver, 60)

        driver.get("https://www.dns-shop.ru")

        for cookie in COOKIES:
            if 'sameSite' in cookie and cookie['sameSite'] not in ["Strict", "Lax", "None"]:
                cookie['sameSite'] = "None"
            driver.add_cookie(cookie)

        url = base_url + str(i)
        driver.get(url)

        try:
            wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, 'a.catalog-product__name span')))
            wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, 'div.product-buy__price')))
        except:
            driver.quit()
            return

        soup = BeautifulSoup(driver.page_source, 'html.parser')
        product_names = soup.select('a.catalog-product__name span')
        product_prices = soup.select('div.product-buy__price')

        for name, price in zip(product_names, product_prices):
            name = name.text.strip()
            price = price.text.strip().replace("\xa0₽", "")
            gpu_data.append({'name': name, 'price': price})

        print(f"Закончили парсить страницу {i}.")

        time.sleep(random.randint(5, 15))

        driver.quit()

    return gpu_data

def print_table(gpu_data):
    with open('gpu_parsed.txt', 'w') as f:
        for gpu in gpu_data:
            line = "Name: " + gpu['name'] + ", Price: " + gpu['price'] + "\n"
            f.write(line)

gpu_data = get_gpu_data()
print_table(gpu_data)