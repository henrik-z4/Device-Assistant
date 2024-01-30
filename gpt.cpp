/* Данный код лицензирован GNU General Public Licence v3.0
Автор: Мурадян Генрик
По всем вопросам обращайтесь: muradyango@student.bmstu.ru

Этот файл содержит реализацию класса GPT, который предоставляет методы для получения ответа от модели генеративной GPT.
 */

#if defined(slots)
#undef slots
#endif

#include <Python.h>

#ifndef slots
#define slots Q_SLOTS
#endif

#include "gpt.h"
#include <QProcess>
#include <QCoreApplication>

#include <iostream>

GPT::GPT(QObject *parent) : QObject(parent) {
    // Конструктор класса GPT
}

QString GPT::getResponse(const QString &prompt) {
    // Получение ответа от GPT модели на основе заданного промпта
    QString response = get_response_from_gpt(prompt);
    emit responseReceived(response);
    return response;
}

// Функция get_response_from_gpt получает ответ от модели GPT на основе заданного промпта
QString GPT::get_response_from_gpt(const QString &prompt) {
    Py_Initialize(); // Инициализация интерпретатора Python

    if (!Py_IsInitialized()) {
        std::cout << "Python interpreter not initialized" << std::endl;
    }

    PyRun_SimpleString("import sys"); // Импорт модуля sys
    PyRun_SimpleString("import os");

    PyRun_SimpleString("print(os.getcwd())"); 
    PyRun_SimpleString("print(sys.path)"); // Дебаг: вывод директорий, в которых ищет модули Python

    QString pythonPathAddition = QString("sys.path.append('%1')").arg(QCoreApplication::applicationDirPath()); // Добавление пути к директории приложения в переменную pythonPathAddition
    PyRun_SimpleString(pythonPathAddition.toStdString().c_str()); // Выполнение строки pythonPathAddition для добавления пути в sys.path
    PyObject *pName = PyUnicode_DecodeFSDefault("GPTWrapper"); // Создание объекта с именем модуля
    PyObject *pModule = PyImport_Import(pName); // Импорт модуля GPTWrapper

    if (pModule == nullptr) {
        std::cout << "Failed to import module" << std::endl;
    }   

    Py_DECREF(pName); // Освобождение памяти, занятой объектом pName
    if (pModule != nullptr) {
        PyObject *pFunc = PyObject_GetAttrString(pModule, "get_gpt4_response"); // Получение объекта функции get_gpt4_response
        if (pFunc && PyCallable_Check(pFunc)) {
            PyObject *pArgs = PyTuple_New(1); // Создание кортежа аргументов

            std::string prompt_utf8 = prompt.toUtf8().constData(); // Преобразование промпта в UTF-8
            PyObject *pValue = PyUnicode_FromString(prompt_utf8.c_str()); // Преобразование QString в Python-строку

            std::cout << "Prompt: " << prompt_utf8<< std::endl;

            PyTuple_SetItem(pArgs, 0, pValue); // Установка первого элемента кортежа аргументов
            PyObject *pResult = PyObject_CallObject(pFunc, pArgs); // Вызов функции get_gpt4_response с передачей аргументов

            if (pResult == nullptr) {
                std::cout << "Failed to call function" << std::endl;
                PyErr_Print(); // Вывод ошибки в консоль
            }

            Py_DECREF(pArgs); // Освобождение памяти, занятой объектом pArgs
            if (pResult != nullptr) {
                QString response = QString::fromUtf8(PyUnicode_AsUTF8(pResult)); // Преобразование Python-строки в QString
                std::cout << response.toStdString() << std::endl; // Дебаг: вывод полученного ответа
                Py_DECREF(pResult); // Освобождение памяти, занятой объектом pResult
                return response; // Возврат полученного ответа
            }
        }
    }
    Py_Finalize(); // Завершение работы интерпретатора Python
    return ""; // Возврат пустой строки, если ответ не был получен
}