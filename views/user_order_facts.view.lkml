view: user_order_facts {

  derived_table: {
    datagroup_trigger: pgendpoint_the_look_model_default_datagroup
    # create_process allows us to explicitly handle the DDL and avoid the "result returned" error
    create_process: {
      sql_step:
        CREATE TABLE ${SQL_TABLE_NAME} AS
        SELECT
          user_id,
          COUNT(order_id) as lifetime_orders,
          MIN(created_at) as first_order_date
        FROM main.orders
        GROUP BY 1 ;;
    }
  }


  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_order_date ;;
  }
}
