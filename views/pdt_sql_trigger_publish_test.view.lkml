view: pdt_sql_trigger_publish_test {
  derived_table: {
    sql:
      SELECT
        status,
        COUNT(*) as order_count
      FROM main.orders
      GROUP BY 1 ;;

    sql_trigger_value: SELECT MAX(order_id) FROM main.orders ;;
    indexes: ["status"]
    publish_as_db_view: yes
  }

  dimension: status {
    primary_key: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  measure: total_orders {
    type: sum
    sql: ${order_count} ;;
  }
}
