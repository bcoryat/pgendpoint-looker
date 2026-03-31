view: pdt_test {
  derived_table: {
    sql:
      SELECT
        state as user_state,
        COUNT(*) as user_count
      FROM main.users
      GROUP BY 1 ;;

    # This tells Looker when to rebuild the table
      sql_trigger_value: SELECT EXTRACT(HOUR FROM CURRENT_TIMESTAMP) ;;
      # suppress the validator warning
      indexes: ["user_state"]
      publish_as_db_view: yes
    }

    dimension: user_state {
      type: string
      sql: ${TABLE}.user_state ;;
    }

    dimension: user_count {
      type: number
      sql: ${TABLE}.user_count ;;
    }
  }
