/*

1. Создайте три таблицы так чтобы: 
в первой хранились фамилии, 
во второй имена, 
в третьей - отчества.

2. Заполните значениями: 
Иванов, Петров, Сидоров. 
Иван, Петр, Сидор.
Иванович, Петрович, Сидорович.

3. Напишите запрос, результат выполнения которого будет возвращать три Ф.И.О целиком: Иванов Иван Иванович, Петров Петр Петрович, Сидоров Сидор Сидорович, но в обратном алфавитном порядке (по убыванию).

4. В качестве результата приложите файл с запросами для всего вышеперечисленного. Оформление и формат файла - любые. 

 */


CREATE TABLE IF NOT EXISTS surname_t (
    id SERIAL PRIMARY KEY,
	surname_c text
);

CREATE TABLE IF NOT EXISTS name_t (
    id SERIAL PRIMARY KEY,
	name_c text
);

CREATE TABLE IF NOT EXISTS patronymic_t (
    id SERIAL PRIMARY KEY,
	patronymic_c text
);

INSERT INTO surname_t (surname_c)  VALUES 
    ('Иванов'),
    ('Петров'),
    ('Сидоров');

INSERT INTO name_t (name_c) VALUES 
    ('Иван'),
    ('Петр'),
    ('Сидор');

INSERT INTO patronymic_t (patronymic_c) VALUES 
    ('Иванович'),
    ('Петрович'),
    ('Сидорович');

SELECT 	
	CONCAT(surname_c, ' ',  name_c, ' ', patronymic_c) AS full_name
FROM 
	name_t 
	LEFT JOIN surname_t st USING(id)
	LEFT JOIN patronymic_t pt USING(id)
ORDER BY 
	full_name DESC;

/*
DROP TABLE name_t;

DROP TABLE surname_t;

DROP TABLE patronymic_t;
*/