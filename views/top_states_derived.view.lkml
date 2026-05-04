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
    primary_key: yes
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_rank {
    type: number
    sql: ${TABLE}.state_rank ;;
  }

  dimension: user_count {
    type: number
    sql: ${TABLE}.user_count ;;
    description: "Pre-aggregated user count per state"
  }

  measure: total_users_in_top_states {
    type: sum
    sql: ${user_count} ;;
    description: "Sum of pre-aggregated user counts from derived table"
  }
}
