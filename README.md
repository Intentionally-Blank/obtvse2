# Obtvse 2.1


A clean and simple markdown blogging platform on Rails.


## Migrating

This Branch is not compatable with earlier versions


## Opinions

TL;DR; unless you're me you should probably just pay the $ to https://svbtle.com and host your blog there.

- Very minimalist.  The page size should be very small and the design is intentionally brutalist
- Posts are a collection of versions that evolve over time.  A post may be updated any number of times and some of those versions may be published for the world to see. Multiple publish dates are shown
- Authentication is delegated to an outside authority (uses JWTs).  As such multi-users are supported but, bylines are not.  The blog is intended for use by a single person or a group of people speaking as one (think The Economist).
- Very robust RSS support.  No support for OG tags, Twitter tags, or AMP.  I'm old school like that and am not interested in pushing my content to someoneelse's walled garden
- Pages are based on time not a cursor.  This means index pages are more stable. This also means it's not suitable if you're publishing more frequently than 1 per day (pages will have a max count of 31) or less than once per week (will have a min count of 4).  That said it still handles skipping a blank page.
- Canonical URLs are largely managed for you.  If you edit the slug or publish a new version old links should automagically redirect to the current canonical version
- No front-end analytics or comments (GA, discourse,  et al).  You can get vanity metrics from your logs and I'm finding myself less and less of a fan of the "free" service data miners. Before you say, "I need analytics & comments on my blog" realize that Seth Godin doesn't have either.

