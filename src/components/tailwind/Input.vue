<template>
  <div>
    <label class="block text-sm font-medium leading-6 text-gray-900" v-html="label" />
    <span class="block text-xs leading-6 text-gray-700" v-if="subLabel" v-html="subLabel" />
    <div class="mt-1 relative">
      <input
        :type="showPassword ? 'text' : type"
        class="block w-full rounded-md border-0 p-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
        :placeholder="placeholder || ''"
        :required="required"
        :value="$props.modelValue"
        @input="updateModelValue"
        :name="$props.name"
        :disabled="readonly || false"
      />
      <div
        class="absolute top-1/2 -translate-y-1/2 right-3 h-full flex justify-center items-center"
        v-if="type === 'password'"
      >
        <span
          class="leading-none hover:text-blue-700 cursor-pointer"
          @click="showPassword = !showPassword"
        >
          <i class="fa-solid fa-eye-slash" v-if="showPassword"></i>
          <i class="fa-solid fa-eye" v-else></i>
        </span>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, type PropType } from 'vue'

export default {
  name: 'TInput',
  props: {
    label: String,
    subLabel: String,
    placeholder: String,
    required: Boolean,
    type: String,
    name: String,
    modelValue: { type: String as PropType<any> },
    readonly: Boolean
  },
  emits: { 'update:model-value': (value: any) => value, input: (e: Event) => e },
  setup(_, { emit }) {
    const showPassword = ref(false)

    return {
      updateModelValue(e: Event) {
        emit('input', e)
        const target = e.target as HTMLInputElement
        emit('update:model-value', target.value)
      },
      showPassword
    }
  }
}
</script>
