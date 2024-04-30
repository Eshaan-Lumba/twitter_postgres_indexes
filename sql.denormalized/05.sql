SELECT tag, count(*)
FROM (
    SELECT DISTINCT
        data->>'id',
        '#' || (jsonb_array_elements(data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') AS tag
        FROM tweets_jsonb
        WHERE data->>'lang' = 'en' AND 
        to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english','coronavirus')
    ) t
    GROUP BY tag
    ORDER BY count DESC, tag
    LIMIT 1000;
