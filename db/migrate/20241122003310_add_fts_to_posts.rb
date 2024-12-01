class AddFtsToPosts < ActiveRecord::Migration[7.2]
  def change
    execute <<-SQL
      CREATE INDEX posts_full_text_search_idx
      ON posts
      USING gin(to_tsvector('portuguese', name || ' ' || text));
    SQL
  end
end
