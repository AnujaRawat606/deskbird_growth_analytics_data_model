select 
  event_time,
  year(event_time) as event_year,
  case 
    when quarter(event_time) < 10 then concat(year(event_time), "-Q0", quarter(event_time))
    else concat(year(event_time), "-M", quarter(event_time))
  end as event_quarter,
  case 
    when month(event_time) < 10 then concat(year(event_time), "-M0", month(event_time))
    else concat(year(event_time), "-M", month(event_time))
  end as event_month,
  company_id,
  user_id,
  event_type,
  plan_tier,
  seats_used
from product_usage_events
