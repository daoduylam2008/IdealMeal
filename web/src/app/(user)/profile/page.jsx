'use client';
import { Hr, ForwardArrow, Modify, Loader } from '@/app/components/icons';
import { ColorfulButton } from '@/app/components/buttons/buttons';
import { ProfileModal } from '@/app/components/modals/modals';
import { getProfile } from '@/app/utils/controllers/actions';
import { useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { logout } from '@/app/utils/controllers/auth';

function Profile() {
  const router = useRouter();
  const profileQuery = useQuery({
    queryKey: ['profile'],
    queryFn: () => getProfile(),
    refetchOnWindowFocus: true,
  });
  if (profileQuery.isPending) {
    return (
      <div className="flex min-h-full flex-1 flex-col items-center space-y-5 px-5 py-10 transition-all duration-300 max-sm:min-h-full sm:space-y-10">
        <Loader />
      </div>
    );
  }
  const handleOpenProfileModal = () => {
    const profileModal = document.getElementById('profile-modal');
    profileModal.showModal();
  };
  const handleVerify = () => {
    router.push('/verify');
  };

  return (
    <>
      <div className="flex min-h-full flex-col items-center space-y-5 px-5 py-10 transition-all duration-300 sm:space-y-10">
        <div className="relative flex w-[calc(100vw-6rem)] max-w-2xl flex-col items-center rounded border-2 border-border transition-all duration-300 max-sm:w-full">
          <span className="absolute -top-5 h-32 w-32 rounded-full border-2 border-border bg-light transition-all duration-300 max-sm:h-[6.5rem] max-sm:w-[6.5rem]"></span>
          <div className="my-3 flex justify-between self-stretch px-1 py-3.5 sm:my-4 sm:px-7 sm:py-5">
            <div className="flex-1 text-center">
              <p className="mb-1">Room</p>
              <span className="h2">{profileQuery.data.room_id}</span>
            </div>
            <div className="flex-1"></div>
            <div className="flex-1 text-center">
              <p className="mb-1">Class</p>
              <span className="h2">{`${Math.floor(profileQuery.data.student_id / 10000)}A${Math.floor((profileQuery.data.student_id % 10000) / 100)}`}</span>
            </div>
          </div>
          <div className="self-stretch px-9">
            <Hr />
          </div>
          <div className="mx-9 flex items-center justify-center self-stretch overflow-hidden">
            <span className="h2 my-4 overflow-hidden text-ellipsis whitespace-nowrap sm:my-5">
              {profileQuery.data.name}
            </span>
          </div>
        </div>
        <div className="w-[calc(100vw-6rem)] max-w-2xl rounded border-2 border-border transition-all duration-300 max-sm:w-full">
          <div className="flex items-center justify-between">
            <span className="h2 ml-9 py-4 sm:py-5">Details</span>
            <div
              className="flex items-center justify-center self-stretch px-9 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0.5"
              onClick={handleOpenProfileModal}
            >
              <Modify />
            </div>
          </div>
          <div className="px-9">
            <Hr />
          </div>

          <div
            className="flex items-center justify-between px-9 py-4 transition-all duration-300 hover:bg-light sm:py-5"
            onClick={handleOpenProfileModal}
          >
            <p className="mb-1 max-sm:hidden">Phone</p>
            <div className="flex max-w-md justify-between overflow-hidden max-sm:flex-col sm:w-3/4 sm:items-center">
              <p className="mb-1 sm:hidden">Phone</p>
              <span className="h4 overflow-hidden text-ellipsis whitespace-nowrap">
                {`${profileQuery.data.phone}`}
              </span>
              <div className="ml-6 max-sm:hidden">
                <ForwardArrow />
              </div>
            </div>
            <div className="ml-6 sm:hidden">
              <ForwardArrow />
            </div>
          </div>
          <div className="px-9">
            <Hr />
          </div>
          <div
            className="flex items-center justify-between px-9 py-4 transition-all duration-300 hover:bg-light sm:py-5"
            onClick={handleOpenProfileModal}
          >
            <p className="mb-1 max-sm:hidden">Email</p>
            <div className="flex max-w-md justify-between overflow-hidden max-sm:flex-col sm:w-3/4 sm:items-center">
              <p className="mb-1 sm:hidden">Email</p>
              <span className="h4 overflow-hidden text-ellipsis whitespace-nowrap">
                {profileQuery.data.email}
              </span>
              <div className="ml-6 max-sm:hidden">
                <ForwardArrow />
              </div>
            </div>
            <div className="ml-6 sm:hidden">
              <ForwardArrow />
            </div>
          </div>
        </div>

        <div className="w-[calc(100vw-6rem)] max-w-2xl rounded border-2 border-border transition-all duration-300 max-sm:w-full">
          <div className="flex items-center justify-between">
            <span className="h2 ml-9 py-4 sm:py-5">Account</span>
            <div
              className="flex items-center justify-center self-stretch px-9 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0.5"
              onClick={handleVerify}
            >
              <Modify />
            </div>
          </div>
          <div className="px-9">
            <Hr />
          </div>

          <div
            className="flex items-center justify-between px-9 py-4 transition-all duration-300 hover:bg-light sm:py-5"
            onClick={handleVerify}
          >
            <p className="mb-1 max-sm:hidden">Password</p>
            <div className="flex max-w-md justify-between overflow-hidden max-sm:flex-col sm:w-3/4 sm:items-center">
              <p className="mb-1 sm:hidden">Password</p>
              <span className="h4 overflow-hidden text-ellipsis whitespace-nowrap">
                ●●●●●●●●●●●
              </span>
              <div className="ml-6 max-sm:hidden">
                <ForwardArrow />
              </div>
            </div>
            <div className="ml-6 sm:hidden">
              <ForwardArrow />
            </div>
          </div>
        </div>
        <div className="flex w-[calc(100vw-6rem)] max-w-2xl flex-col transition-all duration-300 max-sm:w-full">
          <ColorfulButton content={'Logout'} handleClick={() => logout()} />
        </div>
      </div>
      <ProfileModal
        email={profileQuery.data.email}
        phone={profileQuery.data.phone}
      />
    </>
  );
}

export default Profile;
