<template>
  <div v-for="(item, index) in modelValue" :key="index" :class="item.class || ''">
    <t-textarea
      :label="item.label"
      v-model="item.value"
      :placeholder="item.placeholder"
      :required="item.required"
      :name="item.name || ''"
      v-if="item.type === 'textarea'"
    />

    <t-checkbox
      :label="item.label"
      :name="item.name || ''"
      v-model="item.value"
      v-else-if="item.type === 'checkbox'"
    />

    <span class="block mb-3" v-else-if="item.type === 'block'">
      <span class="block text-sm font-medium leading-6 text-gray-900">
        {{ item.label }}
      </span>
      <span class="text-xs" v-if="item.subLabel">
        {{ item.subLabel }}
      </span>
    </span>

    <t-input
      :name="item.name || ''"
      :label="item.label"
      :subLabel="item.subLabel"
      :type="item.type"
      v-model="item.value"
      :placeholder="item.placeholder"
      :required="item.required"
      v-else
    />
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'
import { TTextarea, TCheckbox, TInput } from './tailwind'

export interface FormInput {
  label: string
  name?: string
  subLabel?: string
  placeholder?: string
  type?: 'text' | 'textarea' | 'checkbox' | 'email' | 'number' | 'block'
  value?: any
  required?: boolean
  class?: string
}

export default {
  name: 'FormRenderer',
  components: { TTextarea, TCheckbox, TInput },
  props: {
    modelValue: {
      type: Array as PropType<Array<FormInput>>,
      default: () => []
    }
  }
}
</script>
