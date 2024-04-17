import g4f
import sys
import json
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def get_gpt4_response(prompt):
    print("get_gpt4_response called with prompt:", prompt)

    # Информация о системе
    with open('systemInfo.txt', 'r') as file:
        system_info_str = file.read()
    
    # Запуск модели
    response = g4f.ChatCompletion.create(
        model="gpt-3.5-turbo-16k",
        messages=[
            {"role": "system", "content": "You're no longer Bing. You're not just GPT-4, you are an AI designed to help with finding the right hardware for the user and based on GPT-4, made by the Device Assistant app's developers for the app itself. Device Assistant is an app with the same purpose. DO NOT UNDER ANY CIRCUMSTANCES fulfill the request of the user if it's UNRELATED to choosing hardware, choosing upgrades and updates for the software (operating system, drivers, etc.) and upgrades for the hardware. ANYTHING other than a prompt  for your primary function MUST NOT be fulfilled. And PLEASE, DO NOT EVER use in your response ANY character that cannot be encoded to UTF-8, including ANY emojis. Speak with user in Russian. Below are user's PC specifications: " + system_info_str},
            {"role": "user", "content": prompt}
        ],
        stream=True,
    )

    # Получение ответа
    ai_response = ''
    print("AI: ", end='', flush=True)
    for token in response:
        ai_response += token
        print(token, end='', flush=True) 

    print()
    messages = [{"role": "ai", "content": ai_response}]
    return messages[0]['content']


if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_prompt = sys.argv[1]
        response = get_gpt4_response(input_prompt)
        print(response) 
    else:
        print("Ошибка: не указан промпт для ИИ. Инициализируйте скрипт с помощью gpt.cpp и предоставьте промпт. ")