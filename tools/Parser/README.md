# Парсер для DNS-SHOP.RU

Это первая версия парсера, которая пока что парсит только видеокарты и их цену с сайта dns-shop.ru. Перед запуском парсера установите необходимые библиотеки: 
```bash
pip install -r requirements.txt
```
В файл cookies.json необходимо вставить любые валидные куки для DNS-SHOP.RU

На вашей системе должен быть установлен Google Chrome последней версии, т. к. для парсинга я использовал ChromeDriver

## Инструкция как получить куки

1. Установите на ваш браузер расширение EditThisCookie:
- Для Google Chrome и других браузеров на Chromium: https://chromewebstore.google.com/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg
- Для Firefox: https://addons.mozilla.org/en-GB/firefox/addon/edithiscookie/

2. Откройте сайт DNS-SHOP.RU. Когда сайт загрузится, откройте расширение EditThisCookie и нажмите на значок экспорта. Куки автоматически скопируются в буфер обмена

![image](https://github.com/henrik-z4/Device-Assistant/assets/152740902/5a2b9641-750c-480b-9d6d-3865b657bf3b)


3. Вставьте ваши куки в файл cookies.json

Крайне не рекомендую пушить ваши собственные куки на прод, используйте только у себя на компьютере. Другим людям не следует иметь доступ к вашим куки - это может быть небезопасно.
