# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170919161153) do

  create_table "microentradas", force: :cascade do |t|
    t.text "contenido"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagen"
    t.index ["usuario_id", "created_at"], name: "index_microentradas_on_usuario_id_and_created_at"
    t.index ["usuario_id"], name: "index_microentradas_on_usuario_id"
  end

  create_table "relaciones", force: :cascade do |t|
    t.integer "seguidor_id"
    t.integer "seguido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seguido_id"], name: "index_relaciones_on_seguido_id"
    t.index ["seguidor_id", "seguido_id"], name: "index_relaciones_on_seguidor_id_and_seguido_id", unique: true
    t.index ["seguidor_id"], name: "index_relaciones_on_seguidor_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "digest_recuerda"
    t.boolean "admin", default: false
    t.string "digest_activacion"
    t.boolean "activado", default: false
    t.datetime "activado_en"
    t.string "digest_reseteo"
    t.datetime "reseteo_enviado_en"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

end
