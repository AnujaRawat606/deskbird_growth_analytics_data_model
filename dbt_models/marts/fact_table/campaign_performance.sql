select 
  case 
    when month(created_at) < 10 then concat(year(created_at), "-M0", month(created_at))
    else concat(year(created_at), "-M", month(created_at))
  end as lead_created_month,
  campaign_id,
  utm_campaign,
  count(lead_id) as total_leads_generated,
  count(opportunity_id) as total_opportunities_generated,
  count(company_id) as total_companies_interested,
  count(case when close_status = 'Won' then opportunity_id end) as total_deals_won,
  sum(case when close_status = 'Won' then amount end) as total_amount,
  sum(case when close_status = 'Lost' then amount end) as lost_opportunity_cost,
  avg(date_diff(trial_end_at, trial_start_at)) as average_trial_duration,
  round(avg(date_diff(opportunity_created_at, created_at)), 0) as average_lead_to_opportunity_time,
  round(avg(date_diff(close_date, created_at)),0) as average_lead_to_deal_time,
  round(avg(date_diff(close_date, opportunity_created_at)), 0) as average_opportunity_to_deal_time
from default.crm_pipeline
group by 
  case 
    when month(created_at) < 10 then concat(year(created_at), "-M0", month(created_at))
    else concat(year(created_at), "-M", month(created_at))
  end,
  campaign_id,
  utm_campaign
