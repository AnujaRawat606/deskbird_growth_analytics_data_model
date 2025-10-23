with paid_ads as(
  SELECT 
    year(date) as ad_year,
    case 
      when month(date) < 10 then concat(year(date), "-M0", month(date))
      else concat(year(date), "-M", month(date))
    end as ad_month_year,
    case 
      when quarter(date) < 10 then concat(year(date), "-Q0", quarter(date))
      else concat(year(date), "-M", quarter(date))
    end as ad_quarter_year,
    campaign_id,
    campaign_name,
    channel,
    utm_source, 
    utm_medium,
    utm_campaign,
    sum(impressions) as total_impressions,
    sum(clicks) as total_clicks,
    sum(cost) as total_cost
from default.paid_ads_deskbird
group by all
)

, crm_pipeline_agg as (
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
    sum(case when close_status = 'Won' then amount end) as total_deal_amount,
    sum(case when close_status = 'Lost' then amount end) as lost_opportunity_cost,
    avg(date_diff(trial_end_at, trial_start_at)) as average_trial_duration,
    round(avg(date_diff(opportunity_created_at, created_at)), 0) as average_lead_to_opportunity_time,
    round(avg(date_diff(close_date, created_at)),0) as average_lead_to_deal_time,
    round(avg(date_diff(close_date, opportunity_created_at)), 0) as average_opportunity_to_deal_time
from default.crm_pipeline
group by all
)

select 
  a.ad_month_year, 
  a.campaign_id,
  a.campaign_name,
  a.channel,
  a.utm_source, 
  a.utm_medium,
  a.utm_campaign,
  total_impressions,
  total_clicks,
  total_cost,
  b.*
from paid_ads a 
join crm_pipeline_agg b 
  on a.ad_month_year = b.lead_created_month
