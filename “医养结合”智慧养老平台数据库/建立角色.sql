-- 授予老年人修改老年人信息表、症状表，查询自己膳食搭配、对应的医生、护理人员的权限；
CREATE ROLE old1 ;
GRANT UPDATE ON TABLE old_basic TO old1 ;
GRANT UPDATE ON TABLE old_people TO old1 ;
GRANT SELECT ON TABLE online_diagnosis TO old1 ; 
GRANT SELECT ON VIEW old_diagnosis_diet TO old1 ;
GRANT SELECT ON VIEW old_diagnosis_service TO old1 ;


-- 授予医院管理人员查询、更新医院及医院员工信息的权限，查询老年人基本信息、身体状况、线上诊断结果的权限
CREATE ROLE dr1 ;
GRANT SELECT ON TABLE old_basic TO dr1 ;
GRANT SELECT ON TABLE health_condition TO dr1 ;
GRANT SELECT,UPDATE,INSERT ON TABLE hospital TO dr1 ;
GRANT SELECT,UPDATE,INSERT ON TABLE doctor TO dr1 ;
GRANT SELECT ON TABLE online_diagnosis TO dr1 ;

-- 授予养老院管理人员查询养老院员工、老年人基本信息、老年人症状的权限，查询、更新服务人员安排的权限
CREATE ROLE c1 ;
GRANT SELECT ON TABLE old_basic TO c1 ;
GRANT SELECT ON TABLE online_diagnosis TO c1 ;
GRANT SELECT ON TABLE center_employees TO c1 ;
GRANT SELECT,UPDATE,INSERT ON TABLE diagnosis_service TO c1 ;

-- 授予平台管理员查询、更新、所有表的权限
CREATE ROLE m1; 
GRANT ALL PRIVILEGES ON TABLE old_people TO m1 ;
GRANT ALL PRIVILEGES ON TABLE old_basic TO m1 ;
GRANT ALL PRIVILEGES ON TABLE hospital TO m1 ;
GRANT ALL PRIVILEGES ON TABLE hspt_department TO m1 ;
GRANT ALL PRIVILEGES ON TABLE doctor TO m1 ;
GRANT ALL PRIVILEGES ON TABLE online_diagnosis TO m1 ;
GRANT ALL PRIVILEGES ON TABLE aged_care_center TO m1 ;
GRANT ALL PRIVILEGES ON TABLE center_department TO m1 ;
GRANT ALL PRIVILEGES ON TABLE center_employees TO m1 ;
GRANT ALL PRIVILEGES ON TABLE user_symptom TO m1 ;
GRANT ALL PRIVILEGES ON TABLE symptom_diet TO m1 ;
GRANT ALL PRIVILEGES ON TABLE diagnosis_service TO m1 ;
GRANT ALL PRIVILEGES ON TABLE survice_employees TO m1 ;
