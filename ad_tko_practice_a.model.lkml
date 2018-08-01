
connection: "video_store"

# include all the views
include: "*.view"

datagroup: caching_policy{
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: caching_policy

explore: store_information {
  from: store

  join: address {
    view_label: "Store Information"
    fields:[address.address, address.district, address.postal_code, address.phone]
    type: left_outer
    sql_on: ${store_information.address_id} = ${address.address_id} ;;
    relationship: one_to_one
  }

  join: city {
    view_label: "Store Information"
    fields: [city.city]
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    view_label: "Store Information"
    fields: [country.country]
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

}

explore: customer_information {
  from: customer
#
#   join: store {
#     type: left_outer
#     sql_on: ${customer_information.store_id} = ${store.store_id} ;;
#     relationship: many_to_one
#   }

  # customer contact information

  join: customer_address {
    from: address
    view_label: "Customer Contact Info"
    fields:[customer_address.address, customer_address.district, customer_address.postal_code, customer_address.phone ]
    type: left_outer
    sql_on: ${customer_information.address_id} = ${customer_address.address_id} ;;
    relationship: many_to_one
  }

  join: customer_city {
    from: city
    view_label: "Customer Contact Info"
    fields:[customer_city.city]
    type: left_outer
    sql_on: ${customer_address.city_id} = ${customer_city.city_id} ;;
    relationship: many_to_one
  }

  join: customer_country {
    from: country
    view_label: "Customer Contact Info"
    fields:[customer_country.country]
    type: left_outer
    sql_on: ${customer_city.country_id} = ${customer_country.country_id} ;;
    relationship: many_to_one
  }

# store contact information

}
