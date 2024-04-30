SELECT data->>'lang' AS lang, count(*)
FROM tweets_jsonb
WHERE data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
OR data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
GROUP BY data->>'lang'
ORDER BY count DESC, lang;
