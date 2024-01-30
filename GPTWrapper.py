# Данный код лицензирован GNU General Public Licence v3.0
# Автор: Мурадян Генрик
# По всем вопросам обращайтесь: muradyango@student.bmstu.ru

# Данный файл взаимодействует с API G4F для получения ответов от ИИ
# Синтаксис работы с API G4F совпадает с синтаксисом API от OpenAI с небольшими изменениями, подробнее читайте в репозитории g4f.


import g4f
import sys
import json

def get_gpt4_response(prompt):
    print("get_gpt4_response called with prompt:", prompt.encode('utf-8'))
    # Инициализация провайдера BING для GPT-4
    provider = g4f.Provider.Bing

    # Открытие файла с промптомом
    with open("gpt4prompt.txt", "r", encoding='utf-8') as file:
        file_content = file.read()

    # Запуск модели GPT-4
    response = g4f.ChatCompletion.create(
        model="gpt-4",
        provider=provider,
        messages=[
            {"role": "system", "content": file_content},
            {"role": "user", "content": prompt}
        ],
        stream=True,
    )

    # Получение ответа от GPT-4
    ai_response = ''
    print("GPT-4: ", end='', flush=True)
    for token in response:
        ai_response += token
        print(token.encode('utf-8'), end='', flush=True) 

    print()
    messages = [{"role": "ai", "content": ai_response}]
    return messages[0]['content']

if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_prompt = sys.argv[1]
        response = get_gpt4_response(input_prompt)
        print(response) 
    else:
        print("Ошибка: не указан промпт для GPT-4. Инициализируйте скрипт с помощью gpt.cpp и предоставьте промпт. ")