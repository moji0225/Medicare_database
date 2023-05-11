#1、表建立

##（1）智能终端
CREATE TABLE old_people  /*老年人身体数据表*/
(oid CHAR(10) PRIMARY KEY,
oname CHAR(10) NOT NULL,
oage INT NOT NULL,
pulse INT NOT NULL,
H_blood_pressure FLOAT NOT NULL,
L_blood_pressure FLOAT NOT NULL,
temperature FLOAT NOT NULL,
SaO2 INT NOT NULL,
BG FLOAT NOT NULL,
sleep_time FLOAT NOT NULL,
else_symptom CHAR(100)
);


## (2)老年人
CREATE TABLE old_basic  /*老年人基本情况表*/
(oid CHAR(10) PRIMARY KEY,
oname CHAR(10) NOT NULL,
osex ENUM('男','女') NOT NULL,
oage INT NOT NULL,
otel CHAR(11) NOT NULL,
oaddress CHAR(50) NOT NULL,
relative CHAR(10),
PMH CHAR(200),
Drug_allergy CHAR(200)
);




CREATE TABLE health_condition  /*老年人健康状况综合得分表*/
(oid CHAR(10) PRIMARY KEY,
oname CHAR(10) NOT NULL,
oage INT NOT NULL,
C_pulse INT NOT NULL,
C_blood_pressure INT NOT NULL,
C_temperature INT NOT NULL,
C_SaO2 INT NOT NULL,
C_BG FLOAT NOT NULL,
C_sleep_time INT NOT NULL
);


### 数据对应得分及症状

CREATE TABLE pulse  /*脉搏表*/
(pulse_per_minuite INT PRIMARY KEY,
pulse_score INT NOT NULL,
pulse_symptom CHAR(100) NOT NULL
);


CREATE TABLE pressure  /*血压表*/
(pressure_H FLOAT PRIMARY KEY,
pressure_L FLOAT NOT NULL,
pressure_score INT NOT NULL,
pressure_symptom CHAR(100) NOT NULL
);


CREATE TABLE temperature  /*体温表*/
(temperature_value FLOAT PRIMARY KEY,
temperature_score INT NOT NULL,
temperature_symptom CHAR(100) NOT NULL
);



CREATE TABLE SaO2  /*血氧饱和度表*/
(SaO2_value INT PRIMARY KEY,
SaO2_score INT NOT NULL,
SaO2_symptom CHAR(100) NOT NULL
);


CREATE TABLE BG  /*血糖表*/
(BG_value FLOAT PRIMARY KEY,
BG_score INT NOT NULL,
BG_symptom CHAR(100) NOT NULL
);


CREATE TABLE sleep_time  /*睡眠时长表*/
(sleep_time FLOAT PRIMARY KEY,
sleep_time_score INT NOT NULL,
sleep_time_symptom CHAR(100) NOT NULL
);


##（3）医院
CREATE TABLE hospital  /*医院表*/
( hspt_id  CHAR (10)  PRIMARY KEY, 
	hspt_name  CHAR (30)  UNIQUE,
	hspt_class	CHAR(10)  NOT NULL,
	hspt_adress	CHAR(50)  NOT NULL,
	hspt_tel  CHAR(50)  	NOT NULL
	);


CREATE TABLE hspt_department  /*医院科室表*/
( dept_id  CHAR(10)	Primary key,
	dept_name	CHAR(10) Unique,
	dept_sympt CHAR(100) NOT NULL
	);


CREATE TABLE doctor  /*医生表*/
( dr_id	CHAR(10)	Primary key, 
	dr_name  CHAR(10)  Unique,
	dr_sex  ENUM('男','女')  NOT NULL,
	job_title  CHAR(10)  NOT NULL,
	aff_hspt_id  CHAR(10) NOT NULL,
	aff_dept_id  CHAR(10) NOT NULL
	);
-- 插入数据后设置外码：
ALTER TABLE doctor ADD CONSTRAINT FOREIGN KEY(aff_hspt_id) REFERENCES hospital(hspt_id);
ALTER TABLE doctor ADD CONSTRAINT FOREIGN KEY(aff_dept_id) REFERENCES hspt_department(dept_id);
	
	
CREATE TABLE online_diagnosis  /*线上诊断记录表*/
    ( treat_id  CHAR(10)  Primary key,
			treat_date  Date  NOT NULL,
			oid  CHAR(10)  ,
			dr_id  CHAR(10)  ,
			sympt  CHAR(100)  NOT NULL,
			diag_rslt  CHAR(30)  NOT NULL,
			instruction  CHAR(100)  NOT NULL
			);
-- 插入数据后设置外码：
ALTER TABLE online_diagnosis ADD CONSTRAINT FOREIGN KEY(oid) REFERENCES old_people(oid);
ALTER TABLE online_diagnosis ADD CONSTRAINT FOREIGN KEY(dr_id) REFERENCES doctor(dr_id);


## (4)养老院

### 养老院组织架构

CREATE TABLE aged_care_center  /*养老院表*/
  (	center_id   CHAR ( 10 )  PRIMARY KEY, 
		center_name CHAR ( 20 ) UNIQUE, 
		center_type		CHAR(8),
		center_loc		CHAR(30),
		center_tel		CHAR(20)
	);


CREATE TABLE center_department  /*养老院部门表*/
    ( dept_id      CHAR ( 10 )   PRIMARY KEY, 
		  dept_name    CHAR ( 10 )  UNIQUE,
			dept_service CHAR ( 100 )  NOT NULL
			);


CREATE TABLE center_employees  /*养老院员工表*/
  ( emp_id	CHAR(10)	PRIMARY KEY,
	  emp_name 	CHAR(10)	UNIQUE,
		emp_sex	ENUM('男','女')	NOT NULL,
		emp_age	SMALLINT	NOT NULL,
		center_id	CHAR(10)	NOT NULL,
		dept_id	CHAR(10)	NOT NULL,
		emp_worktime	SMALLINT	NOT NULL,
		emp_class	CHAR(4)	NOT NULL
		);
-- 插入数据后设置外码：
ALTER TABLE center_employees ADD CONSTRAINT FOREIGN KEY(center_id) REFERENCES aged_care_center (center_id);
ALTER TABLE center_employees ADD CONSTRAINT FOREIGN KEY(dept_id) REFERENCES center_department (dept_id);


### 膳食搭配

CREATE TABLE symptom_diet  /*症状-膳食表*/
 ( symptom    CHAR ( 100 )   PRIMARY KEY,
	 nutrient   CHAR ( 100 )   NOT NULL,
	 diet       CHAR ( 100 )   NOT NULL
 );

	
CREATE TABLE diagnosis_service  /*诊断-服务安排表*/
( treat_id        CHAR ( 10 )     PRIMARY KEY, 
	sugg_service  CHAR ( 100 )   NOT NULL,
	dept_id      CHAR ( 10 )   NOT NULL,
	emp_id     CHAR ( 10 )   NOT NULL
);
-- 插入数据后设置外码：
ALTER TABLE diagnosis_service ADD CONSTRAINT FOREIGN KEY(dept_id) REFERENCES center_department (dept_id);
ALTER TABLE diagnosis_service ADD CONSTRAINT FOREIGN KEY(emp_id) REFERENCES center_employees(emp_id);


