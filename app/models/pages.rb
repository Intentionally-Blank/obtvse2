class Pages

  def self.having_posts
    ActiveRecord::Base
      .connection
      .execute("select distinct(to_char(updated_at, 'YYYY-MM')) from posts order by to_char(updated_at, 'YYYY-MM') desc;")
      .to_a
      .map {|x| x["to_char"]}
  end
end
