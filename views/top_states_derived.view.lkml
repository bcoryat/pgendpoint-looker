view: top_states_derived {
  derived_table: {
    sql:
      SELECT
        state,
        COUNT(*) as user_count,
        RANK() OVER (ORDER BY COUNT(*) DESC) as state_rank
      FROM main.users
      GROUP BY 1 ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_rank {
    type: number
    sql: ${TABLE}.state_rank ;;
  }

  measure: total_users_in_top_states {
    type: sum
    sql: ${TABLE}.user_count ;;
  }
}
