BEGIN

SET	@b_year:=(SELECT yearprocess FROM sys_config LIMIT 1);
SET	@start_d:=concat(@b_year-1,'1001');
SET @end_d:=concat(@b_year,'0930');

#1
DROP TABLE IF EXISTS tst_kpi1;
CREATE TABLE tst_kpi1 (
SELECT @b_year+543 as byear,l.cid ,CURDATE() dupdate
FROM	tmp_labor l  INNER JOIN t_person_anc a ON l.cid=a.cid AND l.bdate =a.bdate AND a.g1_ga <=12
WHERE l.BDATE BETWEEN @start_d AND @end_d  GROUP BY l.cid
);

#2
DROP TABLE IF EXISTS tst_kpi2;
CREATE TABLE tst_kpi2 (
SELECT @b_year+543 as byear,l.cid ,CURDATE() dupdate
FROM	tmp_labor l  INNER JOIN t_person_anc a ON l.cid=a.cid AND l.bdate =a.bdate 
AND a.g1_date is not null AND a.g2_date is not null AND a.g3_date is not null 
AND a.g4_date is not null AND a.g5_date is not null
WHERE l.BDATE BETWEEN @start_d AND @end_d  GROUP BY l.cid
);

#3
DROP TABLE IF EXISTS tst_kpi3;
CREATE TABLE tst_kpi3 (
SELECT @b_year+543 as byear,a.cid ,CURDATE() dupdate
FROM tmp_anc a 
INNER JOIN tmp_drug_opd d on a.cid = d.CID 
AND d.DIDSTD in('201120320037726221781506','201110100019999920381199','101110000003082121781506'
,'201110100019999920381341','201110100019999921881341')
WHERE a.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY a.cid
);

#4
DROP TABLE IF EXISTS tst_kpi4;
CREATE TABLE tst_kpi4 (
SELECT @b_year+543 as byear,'' cid ,CURDATE() dupdate
);

#5
DROP TABLE IF EXISTS tst_kpi5;
CREATE TABLE tst_kpi5 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM prenatal t 
INNER JOIN t_person_cid p ON p.hospcode = t.hospcode AND p.pid = t.pid
WHERE t.HCT_RESULT <= 33  AND t.DATE_HCT BETWEEN @start_d AND @end_d
GROUP BY p.CID
);

#6
DROP TABLE IF EXISTS tst_kpi6;
CREATE TABLE tst_kpi6 (
SELECT @b_year+543 as byear,a.cid ,CURDATE() dupdate
FROM  t_postnatal a 
INNER JOIN tmp_labor l on l.cid = a.cid AND l.BDATE BETWEEN @start_d AND @end_d AND l.BTYPE NOT IN(6)
WHERE a.ppcare1 is not null AND a.ppcare2 is not null AND a.ppcare3 is not null 
GROUP BY l.cid
);

#7
DROP TABLE IF EXISTS tst_kpi7;
CREATE TABLE tst_kpi7 (
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
FROM (
SELECT n.HOSPCODE,n.PID,p.CID,p.BIRTH,n.DATE_SERV,n.FOOD,DATE_FORMAT(n.DATE_SERV,'%m') m
FROM nutrition n INNER JOIN person p ON n.HOSPCODE=p.HOSPCODE AND n.PID=p.PID 
WHERE n.DATE_SERV BETWEEN @start_d AND @end_d AND n.FOOD in('1')
GROUP BY n.HOSPCODE,n.PID
HAVING TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) BETWEEN 0 AND 6 
ORDER BY n.DATE_SERV DESC
) t GROUP BY t.CID
);

#8
DROP TABLE IF EXISTS tst_kpi8;
CREATE TABLE tst_kpi8 (
SELECT @b_year+543 as byear,e.cid ,CURDATE() dupdate
FROM tmp_epi e WHERE e.VACCINETYPE in('401')
AND e.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY e.cid
);

#9
DROP TABLE IF EXISTS tst_kpi9;
CREATE TABLE tst_kpi9 (
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
FROM t_childdev_specialpp t WHERE (INSTR(t.status1,'1') or INSTR(t.status2,'1'))
AND t.date_serv_first BETWEEN @start_d AND @end_d 
GROUP BY t.cid

);

#10
DROP TABLE IF EXISTS tst_kpi10;
CREATE TABLE tst_kpi10 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM t_nutrition_service n 
INNER JOIN t_person_cid p ON p.HOSPCODE = n.hospcode AND p.PID = n.pid
WHERE TIMESTAMPDIFF(YEAR,n.birth,n.DATE_SERV) <= 5
AND nutri2 in(3,4,5) AND nutri3 in(3)
);

#11
DROP TABLE IF EXISTS tst_kpi11;
CREATE TABLE tst_kpi11 (
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
FROM t_childdev_specialpp t 
WHERE t.sp_first ='1B261'
AND t.status2 is not NULL AND t.date_serv_first BETWEEN @start_d AND @end_d 
);

#12
DROP TABLE IF EXISTS tst_kpi12;
CREATE TABLE tst_kpi12 (
SELECT @b_year+543 as byear,n.cid ,CURDATE() dupdate
from t_nutrition05 n
WHERE n.DATE_SERV1  BETWEEN @start_d AND @end_d 
);

#13
DROP TABLE IF EXISTS tst_kpi13;
CREATE TABLE tst_kpi13 (
SELECT @b_year+543 as byear,'' cid ,CURDATE() dupdate
);

#14
DROP TABLE IF EXISTS tst_kpi14;
CREATE TABLE tst_kpi14 (
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
FROM t_person_epi t1
WHERE t1.bcg_date is not null AND t1.hbv1_date is not null AND t1.opv3_date is not null AND t1.dtp3_date is not null 
AND t1.mmr1_date is not null AND t1.hbv3_date is not null AND t1.ipv2_date is not null
);

#15
DROP TABLE IF EXISTS tst_kpi15;
CREATE TABLE tst_kpi15 (
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
 FROM t_person_epi t1
WHERE t1.dtp4_date is not null AND t1.opv4_date is not null 
AND ((je1_date is not null and je2_date is not null and je2_date > je1_date) or (j11_date is not null)) 
);

#16
DROP TABLE IF EXISTS tst_kpi16;
CREATE TABLE tst_kpi16 (
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
 FROM t_person_epi t1
WHERE t1.mmr2_date is not null 
AND ((je1_date is not null AND je2_date is not null AND je3_date is not null 
AND je3_date > je2_date AND je2_date > je1_date)
or (je1_date is not null AND je2_date is not null AND j11_date is not null AND je2_date > je1_date AND j11_date > je2_date)
or (j11_date is not null AND j12_date is not null AND j12_date > j11_date)
or (j11_date is not null AND je1_date is not null AND je1_date > j11_date ))
);

#17
DROP TABLE IF EXISTS tst_kpi17;
CREATE TABLE tst_kpi17 (
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
 FROM t_person_epi t1
WHERE t1.opv5_date is not null AND t1.dtp5_date is not null 
);

#18
DROP TABLE IF EXISTS tst_kpi18;
CREATE TABLE tst_kpi18 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM t_nutrition_service n
INNER JOIN t_person_cid p on p.HOSPCODE= n.hospcode AND p.PID = n.pid
WHERE n.nutri3 in (6)
);

#19
DROP TABLE IF EXISTS tst_kpi19;
CREATE TABLE tst_kpi19 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM t_nutrition_service n
INNER JOIN t_person_cid p on p.HOSPCODE= n.hospcode AND p.PID = n.pid
WHERE  nutri2 in(3,4,5) AND nutri3 in(3)

);

#20
DROP TABLE IF EXISTS tst_kpi20;
CREATE TABLE tst_kpi20 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
from dental t
INNER JOIN t_person_cid p on p.HOSPCODE = t.HOSPCODE AND p.PID = t.PID
WHERE t.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY p.CID
);

#21
DROP TABLE IF EXISTS tst_kpi21;
CREATE TABLE tst_kpi21 (
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM procedure_opd t
INNER JOIN t_person_cid p on p.HOSPCODE = t.HOSPCODE AND p.PID = t.PID
WHERE t.DATE_SERV BETWEEN @start_d AND @end_d  
AND t.PROCEDCODE = '2387030'
GROUP BY p.CID
);

#22
DROP TABLE IF EXISTS tst_kpi22;
CREATE TABLE tst_kpi22 (
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
FROM t_person_epi t1
WHERE t1.mmrs_date IS NOT NULL
);

#23
DROP TABLE IF EXISTS tst_kpi23;
CREATE TABLE tst_kpi23(
SELECT @b_year+543 as byear,'' cid ,CURDATE() dupdate

);

#24
DROP TABLE IF EXISTS tst_kpi24;
CREATE TABLE tst_kpi24(
SELECT @b_year+543 as byear,t1.cid ,CURDATE() dupdate
FROM t_person_epi t1
WHERE t1.dts4_date IS NOT NULL
);

#25
DROP TABLE IF EXISTS tst_kpi25;
CREATE TABLE tst_kpi25(
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM tmp_procedure_opd p
INNER JOIN cwh_dent_icd10tm i ON p.PROCEDCODE=i.ICD10TM 
WHERE DATE_SERV BETWEEN @start_d AND @end_d AND p.CID is not NULL
GROUP BY p.CID 
);

#26
DROP TABLE IF EXISTS tst_kpi26;
CREATE TABLE tst_kpi26(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
from tmp_diag_opd t WHERE t.DIAGCODE LIKE 'K02%'
AND DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY t.CID
);

#27
DROP TABLE IF EXISTS tst_kpi27;
CREATE TABLE tst_kpi27(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
from t_nutrition6up n
WHERE age_ms1 BETWEEN 72 AND 228
AND DATE_SERV1 BETWEEN @start_d AND @end_d
GROUP BY CID
);

#28
DROP TABLE IF EXISTS tst_kpi28;
CREATE TABLE tst_kpi28(
SELECT @b_year+543 as byear,'' cid ,CURDATE() dupdate

);

#29
DROP TABLE IF EXISTS tst_kpi29;
CREATE TABLE tst_kpi29(
SELECT @b_year+543 as byear,'' cid ,CURDATE() dupdate

);

#30
DROP TABLE IF EXISTS tst_kpi30;
CREATE TABLE tst_kpi30(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
from (
SELECT d.HOSPCODE,d.PID,d.DIAGCODE,d.DATE_SERV from diagnosis_opd d WHERE LEFT(d.DIAGCODE,4) in ('Z014','Z124') 
AND d.DATE_SERV  BETWEEN DATE_SUB(@start_d,INTERVAL 5 YEAR) AND DATE_SUB(@end_d,INTERVAL 0 YEAR)
) t  INNER JOIN t_person_cid p ON p.HOSPCODE = t.hospcode AND p.PID = t.pid
GROUP BY p.CID
);

#31
DROP TABLE IF EXISTS tst_kpi31;
CREATE TABLE tst_kpi31(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
 from (
SELECT d.HOSPCODE,d.PID,d.DIAGCODE,d.DATE_SERV from diagnosis_opd d WHERE LEFT(d.DIAGCODE,4) in ('Z123') 
AND d.DATE_SERV  BETWEEN DATE_SUB(@start_d,INTERVAL 0 YEAR) AND DATE_SUB(@end_d,INTERVAL 0 YEAR)
) t  INNER JOIN t_person_cid p ON p.HOSPCODE = t.hospcode AND p.PID = t.pid
GROUP BY p.CID
);

#32
DROP TABLE IF EXISTS tst_kpi32;
CREATE TABLE tst_kpi32(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
from (
SELECT p.HOSPCODE,p.PID,p.CID,p.SEX,n.DATE_SERV,round(n.WAIST_CM) WAIST_CM
,n.WEIGHT,n.HEIGHT,round(n.WEIGHT/((n.HEIGHT/100)*(n.HEIGHT/100)),2) bmi
,if(p.sex='1' AND round(n.WAIST_CM)<=90,1,if(p.sex='2' AND round(n.WAIST_CM)<=80,1,0)) fat
,DATE_FORMAT(n.DATE_SERV,'%m') m
FROM t_ncdscreen n 
INNER JOIN t_person_db p ON n.HOSPCODE=p.HOSPCODE AND n.PID=p.PID 
WHERE 
n.DATE_SERV BETWEEN @start_d AND @end_d 
AND TIMESTAMPDIFF(YEAR,p.BIRTH,n.DATE_SERV)>=35 
GROUP BY p.HOSPCODE,p.PID 
HAVING fat=1
ORDER BY n.DATE_SERV
) t GROUP BY cid
);

#33
DROP TABLE IF EXISTS tst_kpi33;
CREATE TABLE tst_kpi33(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
FROM t_person_dm_screen 
WHERE date_screen is not null AND bslevel >70
AND date_screen BETWEEN @start_d AND @end_d
GROUP BY cid
);

#34
DROP TABLE IF EXISTS tst_kpi34;
CREATE TABLE tst_kpi34(
SELECT @b_year+543 as byear,cid ,CURDATE() dupdate
FROM t_person_ht_screen   
WHERE sbp_1>50 AND dbp_1 >50
AND date_screen BETWEEN @start_d AND @end_d
GROUP BY cid
);

#35
DROP TABLE IF EXISTS tst_kpi35;
CREATE TABLE tst_kpi35(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
FROM tst_pop t 
INNER JOIN tmp_diag_opd d on d.CID = t.cid  AND d.DATE_SERV BETWEEN @start_d AND @end_d
INNER JOIN cdisease c ON d.DIAGCODE = c.diagcode AND c.codemental IS NOT NULL
WHERE FIND_IN_SET('23',t.pop_group)
GROUP BY t.cid
);


#36
DROP TABLE IF EXISTS tst_kpi36;
CREATE TABLE tst_kpi36(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
from t_chronic t
WHERE date_dx BETWEEN @start_d AND @end_d
AND t.diagcode LIKE 'E%'
GROUP BY t.cid
);

#37
DROP TABLE IF EXISTS tst_kpi37;
CREATE TABLE tst_kpi37(
SELECT @b_year+543 as byear,f.cid ,CURDATE() dupdate
FROM t_chronicfu f 
INNER JOIN t_dmht d ON f.cid=d.cid
WHERE  f.control_dm IN(1) AND f.ld_hba1c BETWEEN @start_d AND @end_d
GROUP BY f.cid
);

#38
DROP TABLE IF EXISTS tst_kpi38;
CREATE TABLE tst_kpi38(
SELECT @b_year+543 as byear,p.cid ,CURDATE() dupdate
FROM tmp_procedure_opd p
INNER JOIN cwh_dent_icd10tm i ON p.PROCEDCODE=i.ICD10TM 
INNER JOIN tst_pop tp ON tp.cid = p.CID AND  FIND_IN_SET('24',tp.pop_group)
WHERE DATE_SERV BETWEEN @start_d AND @end_d AND p.CID is not NULL
GROUP BY p.CID 
);

#39
DROP TABLE IF EXISTS tst_kpi39;
CREATE TABLE tst_kpi39(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
 FROM t_chronicfu t
INNER JOIN tst_pop p ON p.cid = t.cid AND FIND_IN_SET('24',p.pop_group)
AND t.ld_foot BETWEEN @start_d AND @end_d
GROUP BY t.cid
);


#40
DROP TABLE IF EXISTS tst_kpi40;
CREATE TABLE tst_kpi40(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
FROM t_chronicfu t
INNER JOIN tst_pop p ON p.cid = t.cid AND FIND_IN_SET('24',p.pop_group)
AND t.ld_retina BETWEEN @start_d AND @end_d
GROUP BY t.cid
);

#41
DROP TABLE IF EXISTS tst_kpi41;
CREATE TABLE tst_kpi41(
SELECT @b_year+543 as byear,t.cid ,CURDATE() dupdate
from t_chronic t
WHERE date_dx BETWEEN @start_d AND @end_d
AND t.diagcode LIKE 'I%'
GROUP BY t.cid
);

#42
DROP TABLE IF EXISTS tst_kpi42;
CREATE TABLE tst_kpi42(
SELECT @b_year+543 as byear,f.cid ,CURDATE() dupdate
FROM t_chronicfu f 
INNER JOIN t_dmht d ON f.cid=d.cid
WHERE  f.control_ht IN(1) AND f.ld_bp1 BETWEEN @start_d AND @end_d
GROUP BY f.cid
);

#43
DROP TABLE IF EXISTS tst_kpi43;
CREATE TABLE tst_kpi43(
SELECT @b_year+543 as byear,t.CID ,CURDATE() dupdate

from t_cvdrisk_fl t WHERE t.L_RISK_SCORE > 0
GROUP BY t.CID

);

#44
DROP TABLE IF EXISTS tst_kpi44;
CREATE TABLE tst_kpi44(
SELECT @b_year+543 as byear,t.CID ,CURDATE() dupdate
FROM t_adl_last_regist t
WHERE t.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY t.CID

);

#45
DROP TABLE IF EXISTS tst_kpi45;
CREATE TABLE tst_kpi45(
SELECT @b_year+543 as byear,''CID ,CURDATE() dupdate


);

#46
DROP TABLE IF EXISTS tst_kpi46;
CREATE TABLE tst_kpi46(
SELECT @b_year+543 as byear,'' CID ,CURDATE() dupdate


);



END