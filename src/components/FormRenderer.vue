<template>
  <div v-for="(item, index) in modelValue" :key="index" :class="item.class || ''">
    <t-textarea
      :label="item.label"
      v-model="item.value"
      :placeholder="item.placeholder"
      :required="item.required"
      :name="item.name || ''"
      :readonly="readonly"
      v-if="item.type === 'textarea'"
    />

    <t-checkbox
      :label="item.label"
      :name="item.name || ''"
      v-model="item.value"
      :readonly="readonly"
      v-else-if="item.type === 'checkbox'"
    />

    <span :class="'block mb-3 ' + (item.class || '')" v-else-if="item.type === 'block'">
      <span class="block text-sm font-medium leading-6 text-gray-900" v-html="item.label" />
      <span class="text-xs" v-if="item.subLabel" v-html="item.subLabel" />
    </span>

    <template v-else-if="item.type === 'radio'">
      <t-radio-group
        :name="item.name"
        :inputs="item.radioInputs"
        v-model="item.value"
        :inline="item.inline"
        :label="item.label"
        :readonly="readonly"
      />
    </template>

    <t-input
      :name="item.name || ''"
      :label="item.label"
      :subLabel="item.subLabel"
      :type="item.type"
      v-model="item.value"
      :placeholder="item.placeholder"
      :required="item.required"
      :readonly="readonly"
      v-else
    />
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'
import { TTextarea, TCheckbox, TInput, TRadioGroup } from './tailwind'

export interface FormInput {
  label?: string
  name?: string
  subLabel?: string
  placeholder?: string
  type?: 'text' | 'textarea' | 'checkbox' | 'email' | 'number' | 'block' | 'radio'
  value?: any
  required?: boolean
  class?: string
  radioInputs?: { label: string; value: any }[]
  inline?: boolean
}

export default {
  name: 'FormRenderer',
  components: { TTextarea, TCheckbox, TInput, TRadioGroup },
  props: {
    modelValue: {
      type: Array as PropType<Array<FormInput>>,
      default: () => []
    },
    readonly: Boolean
  }
}
</script>
