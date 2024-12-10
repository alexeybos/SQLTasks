--1. �������� ���������� � ���� ������, ������� ������ � �����-���� �����, ������ � ����������� �� �� �������.

select d.*, s.* from Dwarves d, Squads s
where s.squad_id = d.squad_id
order by s.name, d.name;

--2. ����� ���� ������ � ���������� "miner", ������� �� ������� �� � ����� ������.

select d.* from Dwarves d
where d.profession = 'miner' and d.squad_id is null;

--3. �������� ��� ������ � ��������� �����������, ������� ��������� � ������� "pending".

select * from Tasks t 
where t.status = 'pending'
and t.priority = (select max(t1.priority) from Tasks t1 where t1.status = 'pending');

--4. ��� ������� �����, ������� ������� ���� �� ����� ���������, �������� ���������� ���������, �������� �� �������.

select d.name, count(*) from Dwarves d, Items i
where d.dwarf_id = i.owner_id
group by d.name;

--5. �������� ������ ���� ������� � ���������� ������ � ������ ������. ����� �������� � ������ ������ ��� ������.

select s.name, count(d.dwarf_id) from Squads s
left outer join Dwarves d on s.squad_id = d.squad_id
group by s.name;

--6. �������� ������ ��������� � ���������� ����������� ������������� ����� ("pending" � "in_progress") � ������ ���� ���������.

select d.profession, count(t.task_id) as cnt from Dwarves d, Tasks t
where d.dwarf_id = t.assigned_to
and t.status in ('pending', 'in_progress')
group by d.profession
order by cnt desc;

--7. ��� ������� ���� ��������� ������ ������� ������� ������, ��������� ����� ����������.

select i.type, avg(d.age) from Dwarves d, Items i
where d.dwarf_id = i.owner_id
group by i.type;

--8. ����� ���� ������ ������ �������� �������� (�� ���� ������ � ����), ������� �� ������� �������� ����������. 

select * from Dwarves d
where not exists (select i.item_id from Items i where i.owner_id = d.dwarf_id)
and d.age > (select avg(d1.age) from Dwarves d1);
