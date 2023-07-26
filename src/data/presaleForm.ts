import type { FormInput } from '@/components/FormRenderer.vue'

export const presaleFormData: FormInput[][] = [
  [
    {
      label: 'Email',
      placeholder: 'Your email',
      type: 'email',
      value: ''
    },
    {
      label: 'Telephone Number',
      placeholder: 'Your answer',
      value: '',
      class: 'my-5'
    },
    {
      label: 'Referral code',
      subLabel: 'Ask whoever introduced you to get such a code.',
      value: '',
      placeholder: 'Your answer'
    }
  ]
]
