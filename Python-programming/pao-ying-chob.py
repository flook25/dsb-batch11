import streamlit as st
import random

st.set_page_config(page_title="Rock Paper Scissors", page_icon="✂️", layout="centered")

st.title("🪨📄✂️ Rock, Paper, Scissors Game")

# Icons
icons = {
    "Rock": "https://cdn-icons-png.flaticon.com/128/595/595737.png",
    "Paper": "https://cdn-icons-png.flaticon.com/128/737/737804.png",
    "Scissors": "https://cdn-icons-png.flaticon.com/128/10363/10363577.png"
}

# Initialize session state
if 'win' not in st.session_state:
    st.session_state.win = 0
    st.session_state.loss = 0
    st.session_state.tie = 0
    st.session_state.round = 0
    st.session_state.last_result = None

# Layout for choices
st.markdown("### Choose Your Move:")
col1, col2, col3 = st.columns(3)

with col1:
    st.image(icons["Rock"], width=80)
    if st.button("Rock"):
        player_choice = "Rock"
with col2:
    st.image(icons["Paper"], width=80)
    if st.button("Paper"):
        player_choice = "Paper"
with col3:
    st.image(icons["Scissors"], width=80)
    if st.button("Scissors"):
        player_choice = "Scissors"

# Play game if user has selected a move
if "player_choice" in locals():
    computer_choice = random.choice(list(icons.keys()))

    if player_choice == computer_choice:
        result = "- Tie 😁 -"
        st.session_state.tie += 1
    elif (player_choice == 'Rock' and computer_choice == 'Paper') or \
         (player_choice == 'Paper' and computer_choice == 'Scissors') or \
         (player_choice == 'Scissors' and computer_choice == 'Rock'):
        result = "- You Loss 😭 -"
        st.session_state.loss += 1
    else:
        result = "- You Win 😎 -"
        st.session_state.win += 1

    st.session_state.round += 1
    st.session_state.last_result = {
        "player": player_choice,
        "computer": computer_choice,
        "result": result
    }

# Show last result
if st.session_state.last_result:
    st.markdown("---")
    st.subheader(f"🎯 Round: {st.session_state.round}")
    col1, col2 = st.columns(2)
    with col1:
        st.markdown("**You:**")
        st.image(icons[st.session_state.last_result["player"]], width=64)
    with col2:
        st.markdown("**Computer:**")
        st.image(icons[st.session_state.last_result["computer"]], width=64)
    st.markdown(f"**Result:** {st.session_state.last_result['result']}")
    st.success(f"🏆 Win: {st.session_state.win} | 😞 Loss: {st.session_state.loss} | 🤝 Tie: {st.session_state.tie}")

# Reset button
if st.button("🔁 Reset Game"):
    st.session_state.win = 0
    st.session_state.loss = 0
    st.session_state.tie = 0
    st.session_state.round = 0
    st.session_state.last_result = None
    st.rerun()  # or st.experimental_rerun() for older versions

