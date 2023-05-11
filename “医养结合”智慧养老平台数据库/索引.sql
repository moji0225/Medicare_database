-- 为老年人基本信息表按老年人编号升序建唯一索引
CREATE UNIQUE INDEX old_basic_oid ON old_basic(oid);

-- 为医院表按医院编号升序建唯一索引
CREATE UNIQUE INDEX hospital_id ON hospital(hspt_id);


