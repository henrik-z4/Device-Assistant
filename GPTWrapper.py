import g4f
import sys
import json

def get_gpt4_response(prompt):
    # Инициализация провайдера BING для GPT-4
    provider = g4f.Provider.Bing

    # Открытие файла с промптомом
    with open("gpt4prompt.txt", "r") as file:
        file_content = file.read()

    # Запуск модели GPT-4
    response = g4f.ChatCompletion.create(
        model="gpt-4",
        provider=provider,
        messages=[
            {"role": "user", "content": prompt + "\n"},
            {"role": "system", "content": file_content}
        ],
        stream=True,
    )

    # Получение ответа от GPT-4
    messages = [message for message in response]
    return json.dumps(messages)  # Возвращаем ответ в виде JSON

if __name__ == "__main__":
    input_prompt = sys.argv[1]
    print(get_gpt4_response(input_prompt))