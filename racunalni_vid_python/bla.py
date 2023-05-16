def get_last_user_data(supabase):
    query = supabase.from_('users').select().order('id').limit(1)
    result = query.execute()

    if len(result.data) > 0:
        user_data = result.data[0]
        return user_data

    return None