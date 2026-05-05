view: pdt_datagroup_test {
  derived_table: {
    datagroup_trigger: pgendpoint_the_look_model_default_datagroup
    publish_as_db_view: yes
    indexes: ["status"]
    sql:
      SELECT
        status,
        COUNT(*) as order_count
      FROM main.orders
      GROUP BY 1 ;;
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
