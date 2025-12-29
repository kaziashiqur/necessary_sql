UPDATE users
SET address = CONCAT(
    JSON_UNQUOTE(JSON_EXTRACT(address, '$.address')), ', ',
    JSON_UNQUOTE(JSON_EXTRACT(address, '$.city')), ', ',
    JSON_UNQUOTE(JSON_EXTRACT(address, '$.state')), ', ',
    JSON_UNQUOTE(JSON_EXTRACT(address, '$.country'))
);
