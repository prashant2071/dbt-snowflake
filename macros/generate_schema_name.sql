{#
    By default dbt builds "<target schema>_<custom schema>", e.g. RAW_SILVER.
    This override uses the custom schema name as-is, so +schema: silver -> SILVER.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
