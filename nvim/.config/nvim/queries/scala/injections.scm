; extends

(interpolated_string_expression 
  interpolator: (identifier) @_id (#any-of? @_id "sql" "fr" "fr0")
  (interpolated_string) @sql (#offset! @sql 0 3 0 -1) (#match? @sql "^\"\"\".*")
  )

(interpolated_string_expression 
  interpolator: (identifier) @_id (#any-of? @_id "sql" "fr" "fr0")
  (interpolated_string) @sql (#offset! @sql 0 1 0 -1) (#match? @sql "^\"\[^\"].*")
  )
