SELECT '#' || hash AS tag, count(*)
FROM (
    SELECT DISTINCT data->>'id', jsonb_array_elements(data->'entities'->'hashtags')->>'text' AS hash 
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    UNION
    SELECT DISTINCT data->>'id', jsonb_array_elements(data->'extended_tweet'->'entities'->'hashtags')->>'text' AS hash
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

