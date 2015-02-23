namespace :db do
  desc "Set featured post default"
  task set_featured_post: :environment do
    post = Post.first
    post.featured = true
    post.save
  end

  desc "Sets up default mini posts to prevent errors"
  task populate_mini_posts: :environment do
    MiniPost.create(
      title: "Contact",
      body: "This is a section to discuss how to get in touch, accompanied by a contact form.",
      page: "Contact"
    )
    MiniPost.create(
      title: "Home Page Top Quote",
      body: "Short post - keep under 60 characters",
      page: "Home"
    )
    MiniPost.create(
      title: "Home Page Bottom Quote",
      body: "Short post - keep under 60 characters",
      page: "Home"
    )
  end

  task setup_user: :environment do
    User.create(
      first_name: "Ashley",
      last_name: "Sullivan",
      email: "user@example.com",
      password: "password",
      bio: "This is my website where I post my paintings."
    )
  end

  task populate_posts: [:set_featured_post, :populate_mini_posts, :setup_user]

  desc "Reassigns posts in the dated categories"
  task fix_categories: :environment do
    categories_slugs = ["2008-2010", "2012", "2003-2007", "2013", "sold", "available-to-purchase","2014"]
    categories_slugs.each do |slug|
      if category = Category.find_by_slug(slug)
        year = category.slug.split("-")[0]
        posts = category.posts
        category.delete
        posts.map do |p|
          if category.slug == "sold"
            p.available = false
          end
          p.published_at =  "January 1, #{year}"
          p.save
          p.move_to_uncategorized
        end
      end
    end
  end

  desc "Assigns categories to one of two parent categories"
  task assign_parent_categories: :environment do
    style_categories_slugs = ["art", "painting", "watercolor", "acrylic", "acylic", "bold", "geometric"]
    style_categories_slugs.each do |slug|
      if category = Category.find_by_slug(slug)
        category.parent = "style"
        category.save
      end
    end
    subject_categories_slugs = ["landscape", "abstract", "map", "milwaukee", "city", "industrial"]
    subject_categories_slugs.each do |slug|
      if category = Category.find_by_slug(slug)
        category.parent = "subject"
        category.save
      end
    end
  end
end
