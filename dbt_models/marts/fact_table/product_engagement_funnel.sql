  select 
    case 
      when month(created_at) < 10 then concat(year(created_at), "-M0", month(created_at))
      else concat(year(created_at), "-M", month(created_at))
    end as lead_created_month,
    campaign_id,
    utm_campaign,
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
    count(user_id) as total_users,
    sum(seats_used) as total_seats_used
from default.crm_pipeline a  
left join default.product_usage_events b 
  on a.company_id = b.company_id
group by all
order by a.company_id, 
    case 
      when month(event_time) < 10 then concat(year(event_time), "-M0", month(event_time))
      else concat(year(event_time), "-M", month(event_time))
    end
