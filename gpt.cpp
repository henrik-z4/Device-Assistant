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
    PyRun_SimpleString("import sys"); // Импорт модуля sys
    PyRun_SimpleString("import os");

    PyRun_SimpleString("print(os.getcwd())"); 
    PyRun_SimpleString("print(sys.path)"); // Дебаг: вывод директорий, в которых ищет модули Python

    QString pythonPathAddition = QString("sys.path.append('%1')").arg(QCoreApplication::applicationDirPath()); // Добавление пути к директории приложения в переменную pythonPathAddition
    PyRun_SimpleString(pythonPathAddition.toStdString().c_str()); // Выполнение строки pythonPathAddition для добавления пути в sys.path
    PyObject *pName = PyUnicode_DecodeFSDefault("GPTWrapper"); // Создание объекта с именем модуля
    PyObject *pModule = PyImport_Import(pName); // Импорт модуля GPTWrapper
    Py_DECREF(pName); // Освобождение памяти, занятой объектом pName
    if (pModule != nullptr) {
        PyObject *pFunc = PyObject_GetAttrString(pModule, "get_gpt4_response"); // Получение объекта функции get_gpt4_response
        if (pFunc && PyCallable_Check(pFunc)) {
            PyObject *pArgs = PyTuple_New(1); // Создание кортежа аргументов
            PyObject *pValue = PyUnicode_FromString(prompt.toStdString().c_str()); // Преобразование QString в Python-строку
            PyTuple_SetItem(pArgs, 0, pValue); // Установка первого элемента кортежа аргументов
            PyObject *pResult = PyObject_CallObject(pFunc, pArgs); // Вызов функции get_gpt4_response с передачей аргументов
            Py_DECREF(pArgs); // Освобождение памяти, занятой объектом pArgs
            if (pResult != nullptr) {
                QString response = QString::fromUtf8(PyUnicode_AsUTF8(pResult)); // Преобразование Python-строки в QString
                Py_DECREF(pResult); // Освобождение памяти, занятой объектом pResult
                return response; // Возврат полученного ответа
            }
        }
    }
    Py_Finalize(); // Завершение работы интерпретатора Python
    return ""; // Возврат пустой строки, если ответ не был получен
}