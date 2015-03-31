Sequel::Model.plugin :validation_class_methods
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :nested_attributes
Sequel::Model.plugin :association_dependencies
Sequel::Database.extension :pagination
Sequel::Model.plugin :timestamps
PER_PAGE = 25

module Sequel
  class Model
    class Errors < ::Hash
      ATTRIBUTE_JOINER = I18n.t('errors.joiner').freeze
      def full_messages
        inject([]) do |m, kv|
          att, errors = *kv
          att.is_a?(Array) ? Array(att).map!{|v| I18n.t("attributes.#{v}")} : att = I18n.t("attributes.#{att}")
          errors.each {|e| m << (e.is_a?(LiteralString) ? e : "#{Array(att).join(ATTRIBUTE_JOINER)} #{e}")}
          m
        end
      end
    end
  end
end

Sequel::Plugins::ValidationHelpers::DEFAULT_OPTIONS.merge!({
  :exact_length=>{:message=>lambda{|exact| I18n.t("errors.exact_length", :exact => exact)}},
  :format=>{:message=>lambda{|with| I18n.t("errors.format")}},
  :includes=>{:message=>lambda{|set| I18n.t("errors.include", :values => set.inspect)}},
  :integer=>{:message=>lambda{I18n.t("errors.integer")}},
  :length_range=>{:message=>lambda{|range| I18n.t("errors.length_range", :min => range.min, :max => range.max)}},
  :max_length=>{:message=>lambda{|max| I18n.t("errors.max_length", :max => max)}, :nil_message=>lambda{I18n.t("errors.presence")}},
  :min_length=>{:message=>lambda{|min| I18n.t("errors.min_length", :min => min)}},
  :not_string=>{:message=>lambda{|type| type ? I18n.t("", :type => type) : I18n.t("errors.string")}},
  :numeric=>{:message=>lambda{I18n.t("errors.numeric")}},
  :type=>{:message=>lambda{|type| I18n.t("errors.type", :type => type)}},
  :presence=>{:message=>lambda{I18n.t("errors.presence")}},
  :unique=>{:message=>lambda{I18n.t("errors.unique")}}
})