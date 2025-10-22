select 
  lead_id,
  created_at as lead_created_at,
  year(created_at) as lead_created_year,
  quarter(created_at) as lead_created_quarter,
  case 
    when month(created_at) < 10 then concat(year(created_at), "-M0", month(date))
    else concat(year(created_at), "-M", month(created_at))
  end as lead_created_month_year,
  email_domain,	
  company_id,
  company_name,
  campaign_id,	
  utm_campaign,	
  lifecycle_stage, 	
  opportunity_id,	
  opportunity_created_at,	
  year(opportunity_created_at) as opportunity_created_year,
  quarter(opportunity_created_at) as opportunity_created_quarter,
  case 
    when month(opportunity_created_at) < 10 then concat(year(opportunity_created_at), "-M0", month(date))
    else concat(year(opportunity_created_at), "-M", month(opportunity_created_at))
  end as opportunity_created_month_year,
  amount,	
  close_date as deal_closed_at,	
  year(close_date) as date_closed_year,
  quarter(opportunity_created_at) as date_closed_quarter,
   case 
    when month(close_date) < 10 then concat(year(close_date), "-M0", month(date))
    else concat(year(close_date), "-M", month(close_date))
  end as deal_close_date_month_year,
  close_status,
  trial_start_at,	
  trial_end_at
from crm_pipeline
