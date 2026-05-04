# The name of this view in Looker is "User Order Facts"
view: user_order_facts {

  # This is a Persistent Derived Table (PDT) that pre-aggregates
  # order statistics per user from the orders table.
  # It rebuilds on the datagroup trigger (daily).

  derived_table: {
    datagroup_trigger: pgendpoint_the_look_model_default_datagroup
    # supress lookml warning has no effect on duckdb
    indexes: ["user_id"]
    sql:
      SELECT
        user_id,
        COUNT(order_id) as lifetime_orders,
        MIN(created_at) as first_order_date
      FROM main.orders
      GROUP BY 1 ;;
  }

  # Primary key is user_id — required for joins and symmetric aggregates
  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  # Number of orders placed by this user across their lifetime
  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  # Date of the user's first ever order
  dimension_group: first_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_order_date ;;
  }

  # Average lifetime orders across all users
  # Note: this will trigger symmetric aggregates when used
  # in the order_items explore due to join fanout
  measure: average_lifetime_orders {
    type: average
    sql: ${lifetime_orders} ;;
    value_format_name: decimal_1
  }

  # Count of distinct users with order history
  measure: count {
    type: count
    description: "Count of distinct users with order history"
  }

}
