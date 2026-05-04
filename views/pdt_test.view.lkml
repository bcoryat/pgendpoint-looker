view: pdt_test {
  derived_table: {
    sql:
      SELECT
        state as user_state,
        COUNT(*) as user_count
      FROM main.users
      GROUP BY 1 ;;

    sql_trigger_value: SELECT EXTRACT(HOUR FROM CURRENT_TIMESTAMP) ;;
    publish_as_db_view: yes
    indexes: ["user_state"]
  }

  dimension: user_state {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_state ;;
  }

  dimension: user_count {
    type: number
    sql: ${TABLE}.user_count ;;
  }

  measure: total_users {
    type: sum
    sql: ${user_count} ;;
    description: "Sum of pre-aggregated user counts from derived table"
  }
}
