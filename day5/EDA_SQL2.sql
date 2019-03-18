# 23
select distinct status from bureau_balance;

# 24
select SK_ID_BUREAU,
avg(case when status = 'C' then 1 else 0 end) as status_c_mean,
avg(case when status = 'X' then 1 else 0 end) as status_x_mean,
avg(case when status = '0' then 1 else 0 end) as status_0_mean,
avg(case when status = '1' then 1 else 0 end) as status_1_mean,
avg(case when status = '2' then 1 else 0 end) as status_2_mean,
avg(case when status = '3' then 1 else 0 end) as status_3_mean,
avg(case when status = '4' then 1 else 0 end) as status_4_mean,
avg(case when status = '5' then 1 else 0 end) as status_5_mean
from bureau_balance
group by 1;

# 25
select a.SK_ID_CURR,
avg(case when status = 'C' then 1 else 0 end) as status_c_mean,
avg(case when status = 'X' then 1 else 0 end) as status_x_mean,
avg(case when status = '0' then 1 else 0 end) as status_0_mean,
avg(case when status = '1' then 1 else 0 end) as status_1_mean,
avg(case when status = '2' then 1 else 0 end) as status_2_mean,
avg(case when status = '3' then 1 else 0 end) as status_3_mean,
avg(case when status = '4' then 1 else 0 end) as status_4_mean,
avg(case when status = '5' then 1 else 0 end) as status_5_mean
from application as a
join bureau as b
on a.SK_ID_CURR=b.SK_ID_CURR
join bureau_balance as c
on b.SK_BUREAU_id=c.sk_id_bureau
group by 1;

# 26
select count(*), count(distinct SK_ID_CURR ), count(distinct SK_ID_PREV) from previous_application;

# 27
select *, AMT_APPLICATION / AMT_CREDIT as APP_CREDIT_PERC from previous_application;

# 28
select SK_ID_CURR,
sum(case when NAME_CONTRACT_STATUS in ('Approved','Unused offer') then 1 else 0 end) as num_of_app,
sum(case when NAME_CONTRACT_STATUS in ('Refused') then 1 else 0 end) as num_of_ref
from previous_application group by 1;

# 29
select SK_ID_CURR,
sum(case when NAME_CONTRACT_STATUS in ('Approved','Unused offer') then 1 else 0 end) as num_of_app,
sum(case when NAME_CONTRACT_STATUS in ('Refused') then 1 else 0 end) as num_of_ref,
avg(case when NAME_CONTRACT_STATUS in ('Approved') then AMT_APPLICATION / AMT_CREDIT else null/*why use null?*/ end) as avg_APP_CREDIT_PERC
from previous_application group by 1;

/*
select SK_ID_CURR,
sum(case when NAME_CONTRACT_STATUS in ('Approved','Unused offer') then 1 else 0 end) as num_of_app,
sum(case when NAME_CONTRACT_STATUS in ('Refused') then 1 else 0 end) as num_of_ref,
avg(case when NAME_CONTRACT_STATUS in ('Approved') then AMT_APPLICATION / AMT_CREDIT else 0 end) as avg_APP_CREDIT_PERC
from previous_application group by 1;

select *, AMT_APPLICATION / AMT_CREDIT from previous_application where SK_ID_CURR=100005;
*/

# 30

select SK_ID_CURR, avg(SK_DPD) as avg_sk_dpd, max(SK_DPD) as max_sk_dpd from pos_cash_balance group  by 1;

# 31

-- select * from installments_payments where SK_ID_CURR=100056;

select *, 
case when DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT > 0 then 1 else 0 end as  install_dpd_flag,
case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT > 0 then 1 else 0 end as install_paid_less,
case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT = 0 then 1 else 0 end as install_miss_pay
from installments_payments;

# 32
select SK_ID_CURR, 
avg(case when DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT > 0 then 1 else 0 end) as  avg_install_dpd_flag,
avg(case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT > 0 then 1 else 0 end) as avg_install_paid_less,
avg(case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT = 0 then 1 else 0 end) as avg_install_miss_pay
from installments_payments
group by 1;



# 33
-- select * from credit_card_balance where SK_ID_CURR = 443277;

select SK_ID_CURR, 
sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_7,

sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_7,

sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_7
from
credit_card_balance
group by 1;


# final one
select
base.*,
base2.status_c_mean,
base2.status_x_mean,
base2.status_0_mean,
base2.status_1_mean,
base2.status_2_mean,
base2.status_3_mean,
base2.status_4_mean,
base2.status_5_mean,
base3.num_of_app,
base3.num_of_ref,
base3.avg_APP_CREDIT_PERC,
base4.avg_sk_dpd,
base4.max_sk_dpd,
base5.avg_install_dpd_flag,
base5.avg_install_paid_less,
base5.avg_install_miss_pay,
base6.AMT_BALANCE_1,
base6.AMT_BALANCE_2,
base6.AMT_BALANCE_3,
base6.AMT_BALANCE_4,
base6.AMT_BALANCE_5,
base6.AMT_BALANCE_6,
base6.AMT_BALANCE_7,
base6.AMT_PAYMENT_TOTAL_CURRENT_1,
base6.AMT_PAYMENT_TOTAL_CURRENT_2,
base6.AMT_PAYMENT_TOTAL_CURRENT_3,
base6.AMT_PAYMENT_TOTAL_CURRENT_4,
base6.AMT_PAYMENT_TOTAL_CURRENT_5,
base6.AMT_PAYMENT_TOTAL_CURRENT_6,
base6.AMT_PAYMENT_TOTAL_CURRENT_7,
base6.AMT_CREDIT_LIMIT_ACTUAL_1,
base6.AMT_CREDIT_LIMIT_ACTUAL_2,
base6.AMT_CREDIT_LIMIT_ACTUAL_3,
base6.AMT_CREDIT_LIMIT_ACTUAL_4,
base6.AMT_CREDIT_LIMIT_ACTUAL_5,
base6.AMT_CREDIT_LIMIT_ACTUAL_6,
base6.AMT_CREDIT_LIMIT_ACTUAL_7
from
(select a.*, 
AMT_CREDIT/AMT_ANNUITY as NEW_CREDIT_TO_ANNUITY_RATIO,
AMT_CREDIT/AMT_GOODS_PRICE as NEW_CREDIT_TO_GOODS_RATIO,
OWN_CAR_AGE/DAYS_BIRTH as NEW_CAR_TO_BIRTH_RATIO,
OWN_CAR_AGE/DAYS_EMPLOYED as NEW_CAR_TO_EMPLOY_RATIO,
AMT_CREDIT/AMT_INCOME_TOTAL as NEW_CREDIT_TO_INCOME_RATIO, -- one of the most important variable! DTI
AMT_ANNUITY/AMT_INCOME_TOTAL as NEW_ANNUITY_TO_INCOME_RATIO,
b.NEW_AVG_INC_BY_ORG,
c.cl_max_DAYS_CREDIT,
c.cl_min_DAYS_CREDIT,
c.cl_avg_DAYS_CREDIT,
c.ac_max_DAYS_CREDIT,
c.ac_min_DAYS_CREDIT,
c.ac_avg_DAYS_CREDIT,
c.sd_max_DAYS_CREDIT,
c.sd_min_DAYS_CREDIT,
c.sd_avg_DAYS_CREDIT,
c.bd_max_DAYS_CREDIT,
c.bd_min_DAYS_CREDIT,
c.bd_avg_DAYS_CREDIT,
c.cl_max_DAYS_CREDIT_ENDDATE,
c.cl_min_DAYS_CREDIT_ENDDATE,
c.cl_avg_DAYS_CREDIT_ENDDATE,
c.ac_max_DAYS_CREDIT_ENDDATE,
c.ac_min_DAYS_CREDIT_ENDDATE,
c.ac_avg_DAYS_CREDIT_ENDDATE,
c.sd_max_DAYS_CREDIT_ENDDATE,
c.sd_min_DAYS_CREDIT_ENDDATE,
c.sd_avg_DAYS_CREDIT_ENDDATE,
c.bd_max_DAYS_CREDIT_ENDDATE,
c.bd_min_DAYS_CREDIT_ENDDATE,
c.bd_avg_DAYS_CREDIT_ENDDATE,
c.cl_max_CREDIT_DAY_OVERDUE,
c.ac_max_CREDIT_DAY_OVERDUE,
c.sd_max_CREDIT_DAY_OVERDUE,
c.bd_max_CREDIT_DAY_OVERDUE,
c.cl_avg_CREDIT_DAY_OVERDUE,
c.ac_avg_CREDIT_DAY_OVERDUE,
c.sd_avg_CREDIT_DAY_OVERDUE,
c.bd_avg_CREDIT_DAY_OVERDUE,
c.cl_avg_AMT_CREDIT_MAX_OVERDUE,
c.ac_avg_AMT_CREDIT_MAX_OVERDUE,
c.sd_avg_AMT_CREDIT_MAX_OVERDUE,
c.bd_avg_AMT_CREDIT_MAX_OVERDUE,
c.cl_avg_AMT_CREDIT_SUM,
c.cl_sum_AMT_CREDIT_SUM,
c.ac_avg_AMT_CREDIT_SUM,
c.ac_sum_AMT_CREDIT_SUM,
c.sd_avg_AMT_CREDIT_SUM,
c.sd_sum_AMT_CREDIT_SUM,
c.bd_avg_AMT_CREDIT_SUM,
c.bd_sum_AMT_CREDIT_SUM,
c.cl_avg_AMT_CREDIT_SUM_DEBT,
c.cl_sum_AMT_CREDIT_SUM_DEBT,
c.ac_avg_AMT_CREDIT_SUM_DEBT,
c.ac_sum_AMT_CREDIT_SUM_DEBT,
c.sd_avg_AMT_CREDIT_SUM_DEBT,
c.sd_sum_AMT_CREDIT_SUM_DEBT,
c.bd_avg_AMT_CREDIT_SUM_DEBT,
c.bd_sum_AMT_CREDIT_SUM_DEBT,
c.cl_avg_AMT_CREDIT_SUM_OVERDUE,
c.cl_sum_AMT_CREDIT_SUM_OVERDUE,
c.ac_avg_AMT_CREDIT_SUM_OVERDUE,
c.ac_sum_AMT_CREDIT_SUM_OVERDUE,
c.sd_avg_AMT_CREDIT_SUM_OVERDUE,
c.sd_sum_AMT_CREDIT_SUM_OVERDUE,
c.bd_avg_AMT_CREDIT_SUM_OVERDUE,
c.bd_sum_AMT_CREDIT_SUM_OVERDUE,
c.cl_avg_AMT_CREDIT_SUM_LIMIT,
c.cl_sum_AMT_CREDIT_SUM_LIMIT,
c.ac_avg_AMT_CREDIT_SUM_LIMIT,
c.ac_sum_AMT_CREDIT_SUM_LIMIT,
c.sd_avg_AMT_CREDIT_SUM_LIMIT,
c.sd_sum_AMT_CREDIT_SUM_LIMIT,
c.bd_avg_AMT_CREDIT_SUM_LIMIT,
c.bd_sum_AMT_CREDIT_SUM_LIMIT,
c.cl_avg_AMT_ANNUITY,
c.cl_sum_AMT_ANNUITY,
c.ac_avg_AMT_ANNUITY,
c.ac_sum_AMT_ANNUITY,
c.sd_avg_AMT_ANNUITY,
c.sd_sum_AMT_ANNUITY,
c.bd_avg_AMT_ANNUITY,
c.bd_sum_AMT_ANNUITY,
c.bd_flag,
c.bd_num
from
application as a
left join
(select ORGANIZATION_TYPE, avg(AMT_INCOME_TOTAL) as NEW_AVG_INC_BY_ORG
from application group by 1) as b
on a.ORGANIZATION_TYPE=b.ORGANIZATION_TYPE
left join 
(
select SK_ID_CURR,
max(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT else null end) as cl_max_DAYS_CREDIT,
min(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT else null end) as cl_min_DAYS_CREDIT,
avg(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT else null end) as cl_avg_DAYS_CREDIT,
max(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT else null end) as ac_max_DAYS_CREDIT,
min(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT else null end) as ac_min_DAYS_CREDIT,
avg(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT else null end) as ac_avg_DAYS_CREDIT,
max(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT else null end) as sd_max_DAYS_CREDIT,
min(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT else null end) as sd_min_DAYS_CREDIT,
avg(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT else null end) as sd_avg_DAYS_CREDIT,
max(case when CREDIT_ACTIVE ='Bad Debt' then DAYS_CREDIT else null end) as bd_max_DAYS_CREDIT,
min(case when CREDIT_ACTIVE='Bad Debt' then DAYS_CREDIT else null end) as bd_min_DAYS_CREDIT,
avg(case when CREDIT_ACTIVE='Bad Debt' then DAYS_CREDIT else null end) as bd_avg_DAYS_CREDIT,

max(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT_ENDDATE else null end) as cl_max_DAYS_CREDIT_ENDDATE,
min(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT_ENDDATE else null end) as cl_min_DAYS_CREDIT_ENDDATE,
avg(case when CREDIT_ACTIVE='Closed' then DAYS_CREDIT_ENDDATE else null end) as cl_avg_DAYS_CREDIT_ENDDATE,
max(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT_ENDDATE else null end) as ac_max_DAYS_CREDIT_ENDDATE,
min(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT_ENDDATE else null end) as ac_min_DAYS_CREDIT_ENDDATE,
avg(case when CREDIT_ACTIVE='Active' then DAYS_CREDIT_ENDDATE else null end) as ac_avg_DAYS_CREDIT_ENDDATE,
max(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT_ENDDATE else null end) as sd_max_DAYS_CREDIT_ENDDATE,
min(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT_ENDDATE else null end) as sd_min_DAYS_CREDIT_ENDDATE,
avg(case when CREDIT_ACTIVE='Sold' then DAYS_CREDIT_ENDDATE else null end) as sd_avg_DAYS_CREDIT_ENDDATE,
max(case when CREDIT_ACTIVE ='Bad Debt' then DAYS_CREDIT_ENDDATE else null end) as bd_max_DAYS_CREDIT_ENDDATE,
min(case when CREDIT_ACTIVE='Bad Debt' then DAYS_CREDIT_ENDDATE else null end) as bd_min_DAYS_CREDIT_ENDDATE,
avg(case when CREDIT_ACTIVE='Bad Debt' then DAYS_CREDIT_ENDDATE else null end) as bd_avg_DAYS_CREDIT_ENDDATE,

max(case when CREDIT_ACTIVE='Closed' then CREDIT_DAY_OVERDUE else null end) as cl_max_CREDIT_DAY_OVERDUE,
max(case when CREDIT_ACTIVE='Active' then CREDIT_DAY_OVERDUE else null end) as ac_max_CREDIT_DAY_OVERDUE,
max(case when CREDIT_ACTIVE='Sold' then CREDIT_DAY_OVERDUE else null end) as sd_max_CREDIT_DAY_OVERDUE,
max(case when CREDIT_ACTIVE ='Bad Debt' then CREDIT_DAY_OVERDUE else null end) as bd_max_CREDIT_DAY_OVERDUE,
avg(case when CREDIT_ACTIVE='Closed' then CREDIT_DAY_OVERDUE else null end) as cl_avg_CREDIT_DAY_OVERDUE,
avg(case when CREDIT_ACTIVE='Active' then CREDIT_DAY_OVERDUE else null end) as ac_avg_CREDIT_DAY_OVERDUE,
avg(case when CREDIT_ACTIVE='Sold' then CREDIT_DAY_OVERDUE else null end) as sd_avg_CREDIT_DAY_OVERDUE,
avg(case when CREDIT_ACTIVE='Bad Debt' then CREDIT_DAY_OVERDUE else null end) as bd_avg_CREDIT_DAY_OVERDUE,

avg(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_MAX_OVERDUE else null end) as cl_avg_AMT_CREDIT_MAX_OVERDUE,
avg(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_MAX_OVERDUE else null end) as ac_avg_AMT_CREDIT_MAX_OVERDUE,
avg(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_MAX_OVERDUE else null end) as sd_avg_AMT_CREDIT_MAX_OVERDUE,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_MAX_OVERDUE else null end) as bd_avg_AMT_CREDIT_MAX_OVERDUE,

avg(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM else null end) as cl_avg_AMT_CREDIT_SUM,
sum(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM else null end) as cl_sum_AMT_CREDIT_SUM,
avg(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM else null end) as ac_avg_AMT_CREDIT_SUM,
sum(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM else null end) as ac_sum_AMT_CREDIT_SUM,
avg(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM else null end) as sd_avg_AMT_CREDIT_SUM,
sum(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM else null end) as sd_sum_AMT_CREDIT_SUM,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM else null end) as bd_avg_AMT_CREDIT_SUM,
sum(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM else null end) as bd_sum_AMT_CREDIT_SUM,

avg(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_DEBT else null end) as cl_avg_AMT_CREDIT_SUM_DEBT,
sum(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_DEBT else null end) as cl_sum_AMT_CREDIT_SUM_DEBT,
avg(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_DEBT else null end) as ac_avg_AMT_CREDIT_SUM_DEBT,
sum(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_DEBT else null end) as ac_sum_AMT_CREDIT_SUM_DEBT,
avg(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_DEBT else null end) as sd_avg_AMT_CREDIT_SUM_DEBT,
sum(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_DEBT else null end) as sd_sum_AMT_CREDIT_SUM_DEBT,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_DEBT else null end) as bd_avg_AMT_CREDIT_SUM_DEBT,
sum(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_DEBT else null end) as bd_sum_AMT_CREDIT_SUM_DEBT,

avg(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_OVERDUE else null end) as cl_avg_AMT_CREDIT_SUM_OVERDUE,
sum(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_OVERDUE else null end) as cl_sum_AMT_CREDIT_SUM_OVERDUE,
avg(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_OVERDUE else null end) as ac_avg_AMT_CREDIT_SUM_OVERDUE,
sum(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_OVERDUE else null end) as ac_sum_AMT_CREDIT_SUM_OVERDUE,
avg(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_OVERDUE else null end) as sd_avg_AMT_CREDIT_SUM_OVERDUE,
sum(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_OVERDUE else null end) as sd_sum_AMT_CREDIT_SUM_OVERDUE,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_OVERDUE else null end) as bd_avg_AMT_CREDIT_SUM_OVERDUE,
sum(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_OVERDUE else null end) as bd_sum_AMT_CREDIT_SUM_OVERDUE,

avg(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_LIMIT else null end) as cl_avg_AMT_CREDIT_SUM_LIMIT,
sum(case when CREDIT_ACTIVE='Closed' then AMT_CREDIT_SUM_LIMIT else null end) as cl_sum_AMT_CREDIT_SUM_LIMIT,
avg(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_LIMIT else null end) as ac_avg_AMT_CREDIT_SUM_LIMIT,
sum(case when CREDIT_ACTIVE='Active' then AMT_CREDIT_SUM_LIMIT else null end) as ac_sum_AMT_CREDIT_SUM_LIMIT,
avg(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_LIMIT else null end) as sd_avg_AMT_CREDIT_SUM_LIMIT,
sum(case when CREDIT_ACTIVE='Sold' then AMT_CREDIT_SUM_LIMIT else null end) as sd_sum_AMT_CREDIT_SUM_LIMIT,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_LIMIT else null end) as bd_avg_AMT_CREDIT_SUM_LIMIT,
sum(case when CREDIT_ACTIVE='Bad Debt' then AMT_CREDIT_SUM_LIMIT else null end) as bd_sum_AMT_CREDIT_SUM_LIMIT,

avg(case when CREDIT_ACTIVE='Closed' then AMT_ANNUITY else null end) as cl_avg_AMT_ANNUITY,
sum(case when CREDIT_ACTIVE='Closed' then AMT_ANNUITY else null end) as cl_sum_AMT_ANNUITY,
avg(case when CREDIT_ACTIVE='Active' then AMT_ANNUITY else null end) as ac_avg_AMT_ANNUITY,
sum(case when CREDIT_ACTIVE='Active' then AMT_ANNUITY else null end) as ac_sum_AMT_ANNUITY,
avg(case when CREDIT_ACTIVE='Sold' then AMT_ANNUITY else null end) as sd_avg_AMT_ANNUITY,
sum(case when CREDIT_ACTIVE='Sold' then AMT_ANNUITY else null end) as sd_sum_AMT_ANNUITY,
avg(case when CREDIT_ACTIVE='Bad Debt' then AMT_ANNUITY else null end) as bd_avg_AMT_ANNUITY,
sum(case when CREDIT_ACTIVE='Bad Debt' then AMT_ANNUITY else null end) as bd_sum_AMT_ANNUITY,
max(case when  CREDIT_ACTIVE='Bad Debt'  then 1 else 0 end) as bd_flag, 
sum(case when  CREDIT_ACTIVE='Bad Debt'  then 1 else 0 end) as bd_num
from bureau
group by 1) as c
on a.SK_ID_CURR=c.SK_ID_CURR) as base
left join
(select a.SK_ID_CURR,
avg(case when status = 'C' then 1 else 0 end) as status_c_mean,
avg(case when status = 'X' then 1 else 0 end) as status_x_mean,
avg(case when status = '0' then 1 else 0 end) as status_0_mean,
avg(case when status = '1' then 1 else 0 end) as status_1_mean,
avg(case when status = '2' then 1 else 0 end) as status_2_mean,
avg(case when status = '3' then 1 else 0 end) as status_3_mean,
avg(case when status = '4' then 1 else 0 end) as status_4_mean,
avg(case when status = '5' then 1 else 0 end) as status_5_mean
from application as a
join bureau as b
on a.SK_ID_CURR=b.SK_ID_CURR
join bureau_balance as c
on b.SK_BUREAU_id=c.sk_id_bureau
group by 1) as base2 
on base.SK_ID_CURR=base2.SK_ID_CURR
left join
(select SK_ID_CURR,
sum(case when NAME_CONTRACT_STATUS in ('Approved','Unused offer') then 1 else 0 end) as num_of_app,
sum(case when NAME_CONTRACT_STATUS in ('Refused') then 1 else 0 end) as num_of_ref,
avg(case when NAME_CONTRACT_STATUS in ('Approved') then AMT_APPLICATION / AMT_CREDIT else null/*why use null?*/ end) as avg_APP_CREDIT_PERC
from previous_application group by 1) base3
on base.SK_ID_CURR=base3.SK_ID_CURR
left join
(select SK_ID_CURR, avg(SK_DPD) as avg_sk_dpd, max(SK_DPD) as max_sk_dpd from pos_cash_balance group  by 1) as base4
on base.SK_ID_CURR=base4.SK_ID_CURR
left join
(select SK_ID_CURR, 
avg(case when DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT > 0 then 1 else 0 end) as  avg_install_dpd_flag,
avg(case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT > 0 then 1 else 0 end) as avg_install_paid_less,
avg(case when AMT_INSTALMENT - AMT_PAYMENT > 0  and AMT_PAYMENT = 0 then 1 else 0 end) as avg_install_miss_pay
from installments_payments
group by 1) as base5
on base.SK_ID_CURR=base5.SK_ID_CURR
left join
(select SK_ID_CURR, 
sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_BALANCE else 0 end) as AMT_BALANCE_7,

sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_PAYMENT_TOTAL_CURRENT else 0 end) as AMT_PAYMENT_TOTAL_CURRENT_7,

sum(case when MONTHS_BALANCE = -1 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_1,
sum(case when MONTHS_BALANCE = -2 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_2,
sum(case when MONTHS_BALANCE = -3 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_3,
sum(case when MONTHS_BALANCE = -4 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_4,
sum(case when MONTHS_BALANCE = -5 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_5,
sum(case when MONTHS_BALANCE = -6 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_6,
sum(case when MONTHS_BALANCE = -7 and NAME_CONTRACT_STATUS = 'Active' then AMT_CREDIT_LIMIT_ACTUAL else 0 end) as AMT_CREDIT_LIMIT_ACTUAL_7
from
credit_card_balance
group by 1) as base6
on base.SK_ID_CURR=base6.SK_ID_CURR;