  select 
    case 
      when month(created_at) < 10 then concat(year(created_at), "-M0", month(created_at))
      else concat(year(created_at), "-M", month(created_at))
    end as lead_created_month,
    a.campaign_id,
    channel,
    a.utm_campaign,
    lead_id,
    a.company_id,
    company_name,
    lifecycle_stage,
    case 
      when month(event_time) < 10 then concat(year(event_time), "-M0", month(event_time))
      else concat(year(event_time), "-M", month(event_time))
    end as usage_month,
    event_type,
    plan_tier,
    user_id,
    seats_used
from default.crm_pipeline a  
left join default.product_usage_events b 
  on a.company_id = b.company_id
left join default.paid_ads_deskbird c  
  on a.campaign_id = c.campaign_id
