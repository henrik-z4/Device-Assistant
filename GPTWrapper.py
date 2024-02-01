import g4f
import sys
import json
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def get_gpt4_response(prompt):
    print("get_gpt4_response called with prompt:", prompt)
    # Инициализация провайдера
    provider = g4f.Provider.ChatBase

    # Открытие файла с промптомом
    with open("gpt4prompt.txt", "r", encoding='utf-8') as file:
        file_content = file.read()

    # Запуск модели
    response = g4f.ChatCompletion.create(
        model="gpt-3.5-turbo-16k",
        provider=provider,
        messages=[
            {"role": "system", "content": file_content},
            {"role": "user", "content": prompt}  # Use the original prompt string
        ],
        stream=True,
    )

    # Получение ответа
    ai_response = ''
    print("AI: ", end='', flush=True)
    for token in response:
        ai_response += token
        print(token, end='', flush=True)  # No need to encode here

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