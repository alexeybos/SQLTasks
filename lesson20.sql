-- 1. Найдите все отряды, у которых нет лидера.
SELECT s.name FROM Squads s
WHERE s.leader_id IS NULL;  

--2. Получите список всех гномов старше 150 лет, у которых профессия "Warrior".
SELECT d.dwarf_id, d.name FROM Dwarves d
WHERE d.age > 150 AND d.profession = 'Warrior';
--Т.к. в условиях не было указания на способ написания профессиий, можно "отключить" case sensitive
SELECT d.dwarf_id, d.name FROM Dwarves d
WHERE d.age > 150 AND upper(d.profession) = upper('Warrior');

--3. Найдите гномов, у которых есть хотя бы один предмет типа "weapon".
SELECT DISTINCT d.dwarf_id, d.name FROM Dwarves d
JOIN Items i ON i.owner_id = d.dwarf_id AND i.type = 'weapon';

--4. Получите количество задач для каждого гнома, сгруппировав их по статусу.
SELECT d.dwarf_id, d.name, t.status, count(t.task_id) AS taskCount from Dwarves d
JOIN Tasks t ON t.assigned_to = d.dwarf_id
GROUP BY d.dwarf_id, d.name, t.status
order by d.dwarf_id;

--5. Найдите все задачи, которые были назначены гномам из отряда с именем "Guardians".
SELECT t.task_id, t.description from Tasks t
JOIN Dwarves d ON d.dwarf_id = t.assigned_to
JOIN Squads s ON s.squad_id = d.squad_id AND s.name = 'Guardians';

--6. Выведите всех гномов и их ближайших родственников, указав тип родственных отношений. 
SELECT d.dwarf_id, d.name, r.relationship, d1.dwarf_id, d1.name FROM Relationships r
JOIN Dwarves d ON d.dwarf_id = r.dwarf_id
JOIN Dwarves d1 ON d1.dwarf_id = r.related_to
--WHERE r.relationship != 'Друг' --может не совсем понял задание, но если здесь термин "ближайшие родственники" не включает тип отношений "Друг", то раскомментировать условие
ORDER BY d.dwarf_id;
