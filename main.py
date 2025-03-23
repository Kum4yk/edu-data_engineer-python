from typing import Union, List


ITEM = 'item'  # название товара
CATEGORY = 'category'  # категория товара
PRICE = 'price'  # цена за единицу товара
QUANTITY = 'quantity'  # количество единиц, купленных за один раз

purchases = [
    {ITEM: "apple", CATEGORY: "fruit", PRICE: 1.2, QUANTITY: 10},
    {ITEM: "banana", CATEGORY: "fruit", PRICE: 0.5, QUANTITY: 5},
    {ITEM: "milk", CATEGORY: "dairy", PRICE: 1.5, QUANTITY: 2},
    {ITEM: "bread", CATEGORY: "bakery", PRICE: 2.0, QUANTITY: 3},
]


def total_revenue(purchases: List[dict]) -> Union[int, float]:
    """
    Расчет общей выручки (цена * количество).

    :param purchases: Список покупок.
    :return: Общая выручка.
    """
    result_sum = 0
    for dct in purchases:
        result_sum += dct.get(PRICE, 0) * dct.get(QUANTITY, 0)
    return result_sum


def items_by_category(purchases: List[dict]) -> dict:
    """
    Получение словаря, где ключ — категория,
      а значение — список уникальных товаров в этой категории.

    :param purchases: Список покупок.
    :return: Словарь категорий со списком уникальных товаров.
    """
    result_dct = {}
    for dct in purchases:
        category = dct[CATEGORY]
        result_dct.setdefault(category, [])
        result_dct[category].append(dct[ITEM])
    return result_dct


def expensive_purchases(
    purchases: List[dict],
    min_price: Union[int, float],
) -> List[dict]:
    """
    Найти все покупки, где цена товара больше или равна min_price.

    :param purchases: Список покупок.
    :param min_price: Минимальная цена покупки.
    :return: Покупки, где цена товара больше или равна min_price.
    """
    result_lst = []
    for dct in purchases:
        if dct[PRICE] >= min_price:
            result_lst.append(dct)
    return result_lst


def average_price_by_category(purchases: List[dict]) -> dict:
    """
    Рассчитать среднюю цену товаров по каждой категории.

    :param purchases: Список покупок.
    :return: Средняя цена товаров по каждой категории.
    """
    category_dct = {}
    for dct in purchases:
        category = dct[CATEGORY]
        category_dct.setdefault(category, [])
        category_dct[category].append(dct[PRICE])

    category_price = {}
    for key in category_dct:
        lst = category_dct[key]
        category_price[key] = sum(lst) / len(lst)

    return category_price


def most_frequent_category(purchases: List[dict]) -> str:
    """
    Найти категорию, в которой куплено больше всего единиц товаров.

    :param purchases: Список покупок.
    :return: Категория, в которой куплено больше всего единиц товаров.
    """
    category_dct = {}
    for dct in purchases:
        category = dct[CATEGORY]
        category_dct[category] = category_dct.get(category, 0) + dct[QUANTITY]
    return max(category_dct, key=category_dct.get)


def print_report(
    purchases: List[dict],
    min_price: Union[int, float] = 1,
) -> None:
    """
    Напечатать отчет по покупкам.

    :param purchases: Список покупок.
    :param min_price: Минимальная цена,
    :return:
    """
    result_str = f'''Общая выручка: {total_revenue(purchases)}
Товары по категориям: {items_by_category(purchases)}
Покупки дороже {min_price}: {expensive_purchases(purchases, min_price)}
Средняя цена по категориям: {average_price_by_category(purchases)}
Категория с наибольшим количеством проданных товаров: {most_frequent_category(purchases)}'''
    print(result_str)


if __name__ == '__main__':
    print_report(purchases, 1.0)
