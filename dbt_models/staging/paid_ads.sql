select 
  year(date) as ad_year,
  case 
    when month(date) < 10 then concat(year(date), "-M0", month(date))
    else concat(year(date), "-M", month(date))
  end as ad_month_year,
  case 
    when quarter(date) < 10 then concat(year(date), "-Q0", quarter(date))
    else concat(year(date), "-M", quarter(date))
  end as ad_quarter_year,
  date as ad_date,
  campaign_id,
  campaign_name,
  channel,
  utm_source, 
  utm_medium,
  utm_campaign,
  impressions,
  clicks,
  cost
from paid_ads_deskbird
  
