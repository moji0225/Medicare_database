-- 创建触发器
-- 当在 线上诊断数据表 中插入一条记录时，在 老人-症状-膳食表 中也插入一条对应的膳食建议
CREATE TRIGGER after_insert_online_diagnosis AFTER INSERT ON online_diagnosis FOR EACH ROW
BEGIN
    INSERT INTO symptom_diet (sympt) VALUES(new.sympt);
END